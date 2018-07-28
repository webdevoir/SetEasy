class AddBudgetedToBudgets < ActiveRecord::Migration[5.1]
  def change
    add_column :budgets, :budgeted, :float
  end
end
