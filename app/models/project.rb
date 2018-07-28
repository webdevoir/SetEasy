class Project < ApplicationRecord
  belongs_to :user
  has_many :budgets, dependent: :destroy
  has_many :rentals, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :crews, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
end
