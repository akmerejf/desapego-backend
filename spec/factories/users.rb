FactoryBot.define do
	factory :user do
	  name { Faker::Name.name }
	  
    # user_with_posts will create post data after the user has been created
	    factory :user_with_inventory do
	      # posts_count is declared as a transient attribute and available in
	      # attributes on the factory, as well as the callback via the evaluator
	      ignore do
	        items_count 2
	      end

	      # the after(:create) yields two values; the user instance itself and the
	      # evaluator, which stores all values from the factory, including transient
	      # attributes; `create_list`'s second argument is the number of records
	      # to create and we make sure the user is associated properly to the post
	      	after(:create) do |user, evaluator|
	      	  user.items = create_list(:item, evaluator.items_count, user: user)
		   end	
		end
	end
end