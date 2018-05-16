class AddInteriorToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :interior, :boolean
  end
end
