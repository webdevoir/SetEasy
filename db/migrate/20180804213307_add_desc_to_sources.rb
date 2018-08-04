class AddDescToSources < ActiveRecord::Migration[5.1]
  def change
    add_column :sources, :desc, :string
  end
end
