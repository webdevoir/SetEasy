class ChangeDatesEvents < ActiveRecord::Migration[5.1]
  def change
  	change_column :events, :start, :datetime
  	change_column :events, :end, :datetime
  end
end
