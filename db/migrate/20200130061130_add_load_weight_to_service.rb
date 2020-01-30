class AddLoadWeightToService < ActiveRecord::Migration[6.0]
  def change
    add_column :services, :load_weight, :string
    add_column :services, :load_volume, :string
    add_column :services, :packing, :string
    add_column :services, :contact_name, :string
    add_column :services, :contact_phone, :string
    add_column :profiles, :load_type, :string
  end
end

