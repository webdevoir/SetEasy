class Project < ApplicationRecord
  belongs_to :user
  has_many :budgets
  has_many :rentals
  has_many :locations
  has_many :crews
  has_many :events
end
