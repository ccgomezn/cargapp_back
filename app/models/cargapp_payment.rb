class CargappPayment < ApplicationRecord
  belongs_to :payment_method
  belongs_to :statu
  belongs_to :generator, :class_name => 'User', optional: true
  belongs_to :receiver, :class_name => 'User', optional: true
  belongs_to :bank_account
  belongs_to :service
  belongs_to :company
  belongs_to :user
end
