Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
	  	scope :v1 do
		    resources :users, only: [:create, :update] do
			  collection do
			    post 'confirm'
			    post 'login'
			    post 'email_update'
			  end
			end
			post 'passwords/forgot', to: 'passwords#forgot'
			post 'passwords/reset', to: 'passwords#reset'
			put 'passwords/update', to: 'passwords#update'

			resources :profiles

    		resources :items, path: 'inventory', except: [:new]
    		
		end
    end
end
