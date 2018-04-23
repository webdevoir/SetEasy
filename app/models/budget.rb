class Budget < ApplicationRecord
  belongs_to :location
  has_many :budget_items, dependent: :destroy
  accepts_nested_attributes_for :budget_items, allow_destroy: true, :reject_if => :all_blank
end
