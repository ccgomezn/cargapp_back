class CreateCargappPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :cargapp_payments do |t|
      t.string :uuid
      t.integer :amount
      t.string :transaction_code
      t.text :observation
      t.references :payment_method, null: false, foreign_key: true
      t.references :statu, null: false, foreign_key: true
      t.references :generator#, null: false, foreign_key: true
      t.references :receiver#, null: false, foreign_key: true
      t.references :bank_account, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
