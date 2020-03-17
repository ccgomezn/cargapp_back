# frozen_string_literal: true

class UpdateDatetimeToService < ActiveRecord::Migration[6.0]
  def change
    remove_column :services, :datetime, :date
    add_column :services, :datetime, :datetime
  end
end
