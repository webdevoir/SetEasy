class CreateCrews < ActiveRecord::Migration[5.1]
  def change
    create_table :crews do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :phone
      t.string :availablity
      t.string :skills
      t.string :notes

      t.timestamps
    end
  end
end
