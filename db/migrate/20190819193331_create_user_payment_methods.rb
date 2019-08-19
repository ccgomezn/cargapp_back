class CreateUserPaymentMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :user_payment_methods do |t|
      t.string :email
      t.string :uuid
      t.string :token
      t.string :card_number
      t.date :expiration
      t.string :cvv
      t.text :observation
      t.references :user, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
