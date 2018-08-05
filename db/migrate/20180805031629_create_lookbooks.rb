class CreateLookbooks < ActiveRecord::Migration[5.1]
  def change
    create_table :lookbooks do |t|
      t.references :project, foreign_key: true
      t.references :location, foreign_key: true
      t.string :name
      t.string :image
      t.string :desc

      t.timestamps
    end
  end
end
