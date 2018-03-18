class Item
  include Mongoid::Document
  include Mongoid::Search
  field :name, type: String
  field :description, type: String
  field :image_url, type: String

  embeds_many :photo, as: :photographic
  belongs_to :inventory, validate: false

  validates_presence_of :name

  search_in :description, :name
  
end
