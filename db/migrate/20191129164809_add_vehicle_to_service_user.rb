class AddVehicleToServiceUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :service_users, :vehicle, foreign_key: true
  end
end
