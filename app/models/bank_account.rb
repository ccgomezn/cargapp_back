class BankAccount < ApplicationRecord
  belongs_to :user
  belongs_to :statu
end
