# frozen_string_literal: true

class BankAccount < ApplicationRecord
  belongs_to :user
  belongs_to :statu
  has_one_attached :certificate
end
