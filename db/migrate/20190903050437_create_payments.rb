class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.string :uuid
      t.integer :total
      t.integer :sub_total
      t.integer :taxes
      t.string :transaction_code
      t.text :observation
      t.references :coupon#, null: false, foreign_key: true
      t.string :coupon_code
      t.integer :coupon_amount
      t.references :user_payment_method, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true
      t.references :statu, null: false, foreign_key: true
      t.references :service#, null: false, foreign_key: true
      t.boolean :is_service
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
