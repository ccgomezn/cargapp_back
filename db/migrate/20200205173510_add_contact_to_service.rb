class AddContactToService < ActiveRecord::Migration[6.0]
  def change
    add_column :services, :contact_name, :string
    remove_column :services, :contact_phone, :string
  end
end
