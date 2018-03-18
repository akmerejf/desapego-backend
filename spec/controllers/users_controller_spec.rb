require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	describe "GET index" do
	    it "assigns all users as @users" do
	      user = create(:user)
	      get :index
	      expect(assigns(:users).to_a).to eq([user])
	      expect(response.status).to eq(200)	
	    end
	end
	describe "GET #show" do
	  it "assigns the requested user to @user" do
	    user = create(:user)
	    
	    get :show, params: { id: user.id }
	    expect(assigns(:user)).to eq(user)
	   
	    expect(response.status).to eq(200)
	  end
	end

	describe "DELETE #destroy" do
	  it "removes the requested user" do
	    user = create(:user)
	    
	    delete :destroy, params: { id: user.id }
	    
	    expect(response.status).to eq(200)
	  end
	end	

	
end

