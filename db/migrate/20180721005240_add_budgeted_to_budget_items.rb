class AddBudgetedToBudgetItems < ActiveRecord::Migration[5.1]
  def change
    add_column :budget_items, :budgeted, :float
  end
end
