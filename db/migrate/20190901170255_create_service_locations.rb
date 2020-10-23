class CreateServiceLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :service_locations do |t|
      t.string :longitude
      t.string :latitude
      t.references :city, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
