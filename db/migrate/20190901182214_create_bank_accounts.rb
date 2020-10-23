class CreateBankAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_accounts do |t|
      t.integer :account_number
      t.string :account_type
      t.string :bank
      t.references :user, null: false, foreign_key: true
      t.references :statu, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
