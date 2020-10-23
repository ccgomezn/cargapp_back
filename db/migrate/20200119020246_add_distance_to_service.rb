class AddDistanceToService < ActiveRecord::Migration[6.0]
  def change
    add_column :services, :distance, :decimal
    add_column :services, :duration, :decimal
  end
end
