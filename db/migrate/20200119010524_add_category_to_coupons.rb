class AddCategoryToCoupons < ActiveRecord::Migration[6.0]
  def change
    add_column :coupons, :category, :string
  end
end
