class AddProjectsToBudgets < ActiveRecord::Migration[5.1]
  def change
    add_reference :budgets, :project, foreign_key: true
  end
end
