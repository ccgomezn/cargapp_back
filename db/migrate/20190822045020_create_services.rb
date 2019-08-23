class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :name
      t.string :origin
      t.references :origin_city#, null: false, foreign_key: true
      t.string :origin_address
      t.string :origin_longitude
      t.string :origin_latitude
      t.string :destination
      t.references :destination_city#, null: false, foreign_key: true
      t.string :destination_address
      t.string :destination_latitude
      t.string :destination_longitude
      t.integer :price
      t.text :description
      t.text :note
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :user_driver#, null: false, foreign_key: true
      t.references :user_receiver#, null: false, foreign_key: true
      t.references :vehicle_type, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.references :statu, null: false, foreign_key: true
      t.date :expiration_date
      t.string :contact
      t.boolean :active

      t.timestamps
    end
  end
end
