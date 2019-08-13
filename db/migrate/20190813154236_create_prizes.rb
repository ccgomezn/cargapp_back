class CreatePrizes < ActiveRecord::Migration[6.0]
  def change
    create_table :prizes do |t|
      t.string :name
      t.string :code
      t.integer :point
      t.text :description
      t.text :body
      t.string :image
      t.string :media
      t.datetime :expire_date
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
