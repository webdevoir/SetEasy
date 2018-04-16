class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.text :image
      t.string :desc
      t.boolean :rental
      t.string :source
      t.date :due_date
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
