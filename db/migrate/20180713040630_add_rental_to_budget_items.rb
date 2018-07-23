class AddRentalToBudgetItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :budget_items, :rental, foreign_key: true
  end
end
