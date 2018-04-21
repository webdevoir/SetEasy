class BudgetItem < ApplicationRecord
  belongs_to :budget

  validates_presence_of :item
  # validates_presence_of :rental
  validates_presence_of :price
end
