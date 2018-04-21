class CreateBudgetItems < ActiveRecord::Migration[5.1]
  def change
    create_table :budget_items do |t|
      t.references :budget, foreign_key: true
      t.string :item
      t.boolean :rental
      t.float :price

      t.timestamps
    end
  end
end
