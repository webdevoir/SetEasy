class AddRoleToCrews < ActiveRecord::Migration[5.1]
  def change
    add_column :crews, :role, :string
  end
end
