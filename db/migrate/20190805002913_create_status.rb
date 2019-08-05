class CreateStatus < ActiveRecord::Migration[6.0]
  def change
    create_table :status do |t|
      t.string :name
      t.string :code
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :cargapp_model, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
