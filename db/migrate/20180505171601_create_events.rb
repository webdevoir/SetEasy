class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.date :start
      t.date :end
      t.string :color

      t.timestamps
    end
  end
end
