class BudgetItem < ApplicationRecord
  belongs_to :budget
  belongs_to :rental, optional: true

  validates_presence_of :item
  # validates_presence_of :rental
  # validates_presence_of :price
end
