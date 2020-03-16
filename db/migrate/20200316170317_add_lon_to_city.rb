# frozen_string_literal: true

class AddLonToCity < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :lon, :string
    add_column :cities, :lat, :string
    add_column :cities, :radius, :string
    add_column :services, :datetime, :date
  end
end
