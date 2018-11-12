class CreateJoinTableLocationLocationGroup < ActiveRecord::Migration[5.2]
  def change
    create_join_table :locations, :location_groups do |t|
      t.index [:location_id, :location_group_id]
    end
  end
end
