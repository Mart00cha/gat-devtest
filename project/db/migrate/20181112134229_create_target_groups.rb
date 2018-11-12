class CreateTargetGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :target_groups do |t|
      t.string :name, null: false
      t.string :external_id, null: false
      t.string :secret_code, null: false

      t.references :parent, null: true
      t.references :panel_provider, null: false, foreign_key: true

      t.timestamps
    end
  end
end
