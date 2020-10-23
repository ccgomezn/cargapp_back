class Payment < ApplicationRecord
  belongs_to :coupon, optional: true
  belongs_to :user_payment_method
  belongs_to :payment_method
  belongs_to :statu
  belongs_to :service
  belongs_to :user
end
