class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code
      t.text :description
      t.string :cioc
      t.string :currency_code
      t.string :currency_name
      t.string :currency_symbol
      t.string :language_iso639
      t.string :language_name
      t.string :language_native_name
      t.string :image
      t.string :date_utc
      t.boolean :active

      t.timestamps
    end
  end
end
