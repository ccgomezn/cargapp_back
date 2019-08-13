class CreateUserCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :user_coupons do |t|
      t.string :discount
      t.references :cargapp_model, null: false, foreign_key: true
      t.integer :applied_item_id
      t.references :coupon, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
