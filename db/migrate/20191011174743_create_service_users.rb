class CreateServiceUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :service_users do |t|
      t.references :service, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :position
      t.boolean :approved
      t.date :expiration_date
      t.boolean :active

      t.timestamps
    end
  end
end
