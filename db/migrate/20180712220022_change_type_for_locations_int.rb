class ChangeTypeForLocationsInt < ActiveRecord::Migration[5.1]
  def change
  	change_column :locations, :interior, :string
  end
end
