class RemoveFkProjects < ActiveRecord::Migration[5.1]
  def change
  	remove_foreign_key :projects, column: :user_id
  end
end
