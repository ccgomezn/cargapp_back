class CreatePaymentMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_methods do |t|
      t.string :name
      t.string :uuid
      t.text :description
      t.string :email
      t.string :aap_id
      t.string :secret_id
      t.string :token
      t.string :password
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
