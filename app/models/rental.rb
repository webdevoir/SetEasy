class Rental < ApplicationRecord
  belongs_to :project
  belongs_to :location
  has_one :budget_item, dependent: :destroy

  mount_uploader :image, ImageUploader

  attr_accessor :price


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
