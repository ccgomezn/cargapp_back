class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.string :description
      t.boolean :is_porcentage
      t.integer :value
      t.integer :quantity
      t.references :cargapp_model, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
