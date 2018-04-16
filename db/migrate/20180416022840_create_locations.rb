class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :street
      t.string :postal
      t.string :city
      t.string :province

      t.timestamps
    end
  end
end
