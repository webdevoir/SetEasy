class CreateJoinTableCrewEvent < ActiveRecord::Migration[5.1]
  def change
    create_join_table :crews, :events do |t|
      t.index [:crew_id, :event_id]
      # t.index [:event_id, :crew_id]
    end
  end
end
