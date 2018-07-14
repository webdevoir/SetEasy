class Rental < ApplicationRecord
  belongs_to :project
  belongs_to :location
  has_one :budget_item, dependent: :destroy

  mount_uploader :image, ImageUploader

  attr_accessor :price
  attr_accessor :desc
  attr_accessor :rental
  validates_presence_of :desc
  validates_presence_of :rental


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
