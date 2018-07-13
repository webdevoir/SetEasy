class AddNameToBudget < ActiveRecord::Migration[5.1]
  def change
    add_column :budgets, :name, :string
  end
end
