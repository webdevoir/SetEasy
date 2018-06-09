class Project < ApplicationRecord
  belongs_to :user
  has_many :budgets
  has_many :rentals
  has_many :locations
end
