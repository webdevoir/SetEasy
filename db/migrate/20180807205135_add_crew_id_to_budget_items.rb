class AddCrewIdToBudgetItems < ActiveRecord::Migration[5.1]
  def change
    add_column :budget_items, :crew_id, :integer
  end
end
