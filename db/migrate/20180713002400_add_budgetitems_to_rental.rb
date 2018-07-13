class AddBudgetitemsToRental < ActiveRecord::Migration[5.1]
  def change
    add_reference :rentals, :budget_item, foreign_key: true
  end
end
