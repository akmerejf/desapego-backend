class Profile
  include Mongoid::Document

  field :name, type: String
  field :phone, type: String

  embeds_one :photographic
  belongs_to :user
end
