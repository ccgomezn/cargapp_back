class CreateRateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :rate_services do |t|
      t.integer :service_point
      t.integer :driver_point
      t.integer :point
      t.references :service, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :driver#, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
