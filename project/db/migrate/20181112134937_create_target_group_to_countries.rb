class CreateTargetGroupToCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :target_group_to_countries do |t|
      t.integer :country_id
      t.integer :target_group_id
    end
  end
end
