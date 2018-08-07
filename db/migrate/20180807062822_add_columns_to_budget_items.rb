class AddColumnsToBudgetItems < ActiveRecord::Migration[5.1]
  def change
    add_column :budget_items, :payment, :string
    add_column :budget_items, :reference, :string
  end
end
