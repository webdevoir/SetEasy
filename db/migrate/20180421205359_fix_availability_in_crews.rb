class FixAvailabilityInCrews < ActiveRecord::Migration[5.1]
  def change
  	rename_column :crews, :availablity, :availability
  end
end
