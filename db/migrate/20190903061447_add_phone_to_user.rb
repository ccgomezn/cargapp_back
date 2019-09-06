class AddPhoneToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :phone_number, :integer, :limit => 8
    add_column :users, :mobile_verify, :boolean
    add_column :users, :mobile_code, :string
    add_column :users, :identification, :string
    add_column :users, :uuid, :string
    add_column :users, :provider, :string
    add_column :users, :referal_code, :string
    add_column :users, :user_referal_code, :string
    add_column :users, :pin, :string
    add_column :users, :online, :boolean
    add_column :users, :active, :boolean

    ## Confirmable
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string
  end
end
