class RemoveDescFromRentals < ActiveRecord::Migration[5.1]
  def change
  	remove_column :rentals, :desc
  	remove_column :rentals, :rental
  end
end
