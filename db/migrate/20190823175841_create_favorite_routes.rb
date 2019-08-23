class CreateFavoriteRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_routes do |t|
      t.references :origin_city#, null: false, foreign_key: true
      t.references :destination_city#, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
