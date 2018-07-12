class Rental < ApplicationRecord
  belongs_to :project
  belongs_to :location
  mount_uploader :image, ImageUploader


#   def self.filter(query)
#         if query = "rental"
#           where(rental: true)
#         elsif query = "purchased"
#           where(rental: false)
#         else
#           all
#         end
#       end
end
