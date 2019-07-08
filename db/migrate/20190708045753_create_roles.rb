class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :code
      t.text :description
      t.boolean :active

      t.timestamps
    end
    add_index :roles, :code
  end
end
