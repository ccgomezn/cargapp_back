class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.references :role, null: false, foreign_key: true
      t.references :cargapp_model, null: false, foreign_key: true
      t.string :action
      t.string :method
      t.boolean :allow
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
