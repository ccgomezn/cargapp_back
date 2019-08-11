class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.string :brand
      t.string :model
      t.integer :model_year
      t.string :color
      t.string :plate
      t.string :chassis
      t.string :owner_vehicle
      t.references :vehicle_type, null: false, foreign_key: true
      t.references :owner_document_type#, null: false, foreign_key: true
      t.string :owner_document_id
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
