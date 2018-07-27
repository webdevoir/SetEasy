class AddDresserToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :dresser_days, :string
  end
end
