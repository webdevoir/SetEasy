class Source < ApplicationRecord
  belongs_to :project
  belongs_to :location

    mount_uploader :image, ImageUploader

    validates_presence_of :name
    validates_presence_of :image
end

