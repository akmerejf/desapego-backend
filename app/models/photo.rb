class Photo
  include Mongoid::Document
  embedded_in :photographic, polymorphic: true
  mount_uploaders :picture, PictureUploader
end
