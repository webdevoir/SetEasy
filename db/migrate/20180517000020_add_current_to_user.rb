class AddCurrentToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_project, :string
  end
end
