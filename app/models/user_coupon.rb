class UserCoupon < ApplicationRecord
  belongs_to :cargapp_model
  belongs_to :coupon
  belongs_to :user
  validates :user_id, uniqueness: { scope: [:coupon_id] }
  validates :applied_item_id, uniqueness: { scope: [:cargapp_model_id, :user_id] }
end
