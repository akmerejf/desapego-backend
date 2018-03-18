class UserMailer < ApplicationMailer

	default :from => "doyoueverliftorduck@gmail.com"

	def registration_confirmation(user)
	    @user = user
	    mail(:to => "#{user.email}", :subject => "Registration Confirmation for Awesome App")
	end

	def reset_password(user)
		@user = user
	    mail(:to => "#{@user.email}", :subject => "Password reset instructions")
	end

	def change_email(user)
		@user = user
	    mail(:to => "#{@user.unconfirmed_email}", :subject => "Change email instructions")
	end
end
