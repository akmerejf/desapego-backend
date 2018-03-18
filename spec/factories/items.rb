FactoryBot.define do
	factory :item do |f|
	  f.name { Faker::Book.title }
	  f.owner
	end

end