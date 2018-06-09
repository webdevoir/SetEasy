class Rental < ApplicationRecord
  belongs_to :project
  belongs_to :location
  mount_uploader :image, ImageUploader
end
