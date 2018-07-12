class AddPickDateToRental < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :pick_date, :date
  end
end
