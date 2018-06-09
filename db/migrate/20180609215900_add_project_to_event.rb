class AddProjectToEvent < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :project, foreign_key: true
  end
end
