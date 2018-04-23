class Location < ApplicationRecord
	has_many :budgets, dependent: :destroy
end
