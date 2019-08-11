class UserCoupon < ApplicationRecord
  belongs_to :cargapp_model
  belongs_to :coupon
  belongs_to :user
end
