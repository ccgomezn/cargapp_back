class CreateCargappModels < ActiveRecord::Migration[6.0]
  def change
    create_table :cargapp_models do |t|
      t.string :name
      t.string :code
      t.string :value
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
