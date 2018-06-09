class Location < ApplicationRecord
	belongs_to :project
	has_many :budgets, dependent: :destroy
	has_many :rentals, dependent: :destroy
	has_many :events
end
