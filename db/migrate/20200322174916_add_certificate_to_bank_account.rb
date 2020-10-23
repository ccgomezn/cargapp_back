# frozen_string_literal: true

class AddCertificateToBankAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :bank_accounts, :certificate, :string
    add_column :bank_accounts, :approved, :boolean
  end
end
