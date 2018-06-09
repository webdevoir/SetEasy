class AddProjectToRentals < ActiveRecord::Migration[5.1]
  def change
    add_reference :rentals, :project, foreign_key: true
  end
end
