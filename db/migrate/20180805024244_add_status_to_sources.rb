class AddStatusToSources < ActiveRecord::Migration[5.1]
  def change
    add_column :sources, :rental_id, :integer
  end
end
