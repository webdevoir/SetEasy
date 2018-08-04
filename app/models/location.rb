class Location < ApplicationRecord
	belongs_to :project
	has_many :budgets, dependent: :destroy
	has_many :rentals, dependent: :destroy
	has_many :sources, dependent: :destroy
	has_many :events

	validates_presence_of :name
	# validates_presence_of :city

	validates_uniqueness_of :name, scope: :project_id


	def int_name 
    return "(" + self.interior + ")" + " " + self.name
  end
end
