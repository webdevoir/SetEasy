class Rental < ApplicationRecord
  belongs_to :project
  belongs_to :location
  has_one :budget_item, dependent: :destroy

  mount_uploader :image, ImageUploader

  attr_accessor :price
  attr_accessor :desc
  attr_accessor :rental
  attr_accessor :item

  validates_presence_of :desc, unless: :item_test
  validates_presence_of :rental, unless: :item_test


  def item_test
  	item 
  end

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
