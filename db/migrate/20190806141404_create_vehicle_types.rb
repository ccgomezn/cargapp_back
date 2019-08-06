class CreateVehicleTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicle_types do |t|
      t.string :name
      t.string :code
      t.string :icon
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
