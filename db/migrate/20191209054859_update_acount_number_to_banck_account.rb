class UpdateAcountNumberToBanckAccount < ActiveRecord::Migration[6.0]
  def change
    change_column :bank_accounts, :account_number, :string
    add_column :coupons, :image, :string
  end
end
