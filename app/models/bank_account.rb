# frozen_string_literal: true

class BankAccount < ApplicationRecord
  belongs_to :user
  belongs_to :statu
  has_one_attached :certificate
  validates :account_number, uniqueness: { scope: %i[bank account_type] }
  validates :account_number, :bank, :account_type, presence: true
end
