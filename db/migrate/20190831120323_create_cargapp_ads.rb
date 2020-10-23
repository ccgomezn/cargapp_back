class CreateCargappAds < ActiveRecord::Migration[6.0]
  def change
    create_table :cargapp_ads do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.text :body
      t.string :image
      t.string :url
      t.string :media
      t.boolean :have_discoun
      t.boolean :is_percentage
      t.integer :discoun
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
