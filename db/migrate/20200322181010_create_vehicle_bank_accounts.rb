class CreateVehicleBankAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicle_bank_accounts do |t|
      t.string :account_number
      t.string :account_type
      t.string :bank
      t.references :user, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.references :statu, null: false, foreign_key: true
      t.string :certificate
      t.boolean :active
      t.boolean :approved

      t.timestamps
    end
  end
end
