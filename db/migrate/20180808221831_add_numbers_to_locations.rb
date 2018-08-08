class AddNumbersToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :number, :integer
  end
end
