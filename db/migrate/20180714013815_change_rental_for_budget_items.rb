class ChangeRentalForBudgetItems < ActiveRecord::Migration[5.1]
  def change
  	rename_column :budget_items, :rental, :rent_status
  end
end
