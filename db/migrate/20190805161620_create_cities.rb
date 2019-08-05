class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :code
      t.text :description
      t.references :state, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
