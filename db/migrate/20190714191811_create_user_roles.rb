class CreateUserRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_roles do |t|
      t.references :role, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :admin #, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
