class CreateLocationGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :location_groups do |t|
      t.string :name, null: false
      t.references :panel_provider, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
