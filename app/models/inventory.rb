class Inventory
  include Mongoid::Document
  
  embeds_one :photo, as: :photographic
  belongs_to :user
  has_many :items, dependent: :destroy
end
