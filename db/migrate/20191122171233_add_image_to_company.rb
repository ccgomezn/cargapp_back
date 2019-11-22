class AddImageToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :image, :string
    add_column :companies, :identify, :string
    add_reference :coupons, :company, foreign_key: true
  end
end
