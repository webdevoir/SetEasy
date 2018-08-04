class AddFieldsToSources < ActiveRecord::Migration[5.1]
  def change
    add_column :sources, :vendor, :string
    add_column :sources, :price, :float
  end
end
