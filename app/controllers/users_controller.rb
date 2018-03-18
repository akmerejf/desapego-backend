class UsersController < ApplicationController
	before_action :authenticate_request!, only: :email_update
	before_action :validate_email_update, only: :email_update

	
	# def index
	# 	@users = User.all

	# 	render json: {users: @users}
	# end

	def create
		@user = User.new(user_params)
		if @user.save
			UserMailer.registration_confirmation(@user).deliver
    		# sign_in @user
		else
		  render json: { errors: @user.errors }, status: :unprocessable_entity
		end
	end

	def update
		token = params[:token].to_s
		user = User.find_by(confirmation_token: token)

		if !user || !user.confirmation_token_valid?
			render json: {error: 'The email link seems to be invalid / expired. Try requesting for a new one.'}, status: :not_found
		else
			user.update_new_email!
			render json: {status: 'Email updated successfully'}, status: :ok
		end
	end

	def email_update
		if @current_user.set_new_email(@new_email)
	      UserMailer.change_email(@current_user).deliver
	      render json: { status: 'Email Confirmation has been sent to your new Email.' }, status: :ok
	    else
	      render json: { errors: @current_user.errors.values.flatten.compact }, status: :bad_request
	    end
	end


  	def confirm
	  token = params[:token].to_s

	  user = User.find_by(confirmation_token: token)

	  if user.present? && user.confirmation_token_valid?
	    user.mark_as_confirmed!
	    render json: {status: 'User confirmed successfully'}, status: :ok
	  else
	    render json: {status: 'Invalid token'}, status: :not_found
	  end
	end

	def login
	  user = User.find_by(email: params[:email].to_s.downcase)

	  if user && user.authenticate(params[:password])
	  	if user.confirmed_at?
	      auth_token = JsonWebToken.encode({user_id: user.id})
	      render json: {auth_token: auth_token}, status: :ok
	    else
		   render json: {error: 'Email not verified' }, status: :unauthorized
		end
	  else
	    render json: {error: 'Invalid username / password'}, status: :unauthorized
	  end
	end



	private	

 	def validate_email_update
      @new_email = params[:email].to_s.downcase

      if @new_email.blank?
        return render json: { status: 'Email cannot be blank' }, status: :bad_request
      end

      if  @new_email == @current_user.email
        return render json: { status: 'Current Email and New email cannot be the same' }, status: :bad_request
      end

      if User.email_used?(@new_email)
        return render json: { error: 'Email is already in use.' }, status: :unprocessable_entity
      end
    end

	def user_params
    	params.require(:user).permit(:email, :password, :password_confirmation)
  	end
end