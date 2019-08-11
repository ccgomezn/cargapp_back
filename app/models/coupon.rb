class Coupon < ApplicationRecord
  belongs_to :cargapp_model
  belongs_to :user

  validates :name, :code, uniqueness: true
  validates :name, :code, presence: true
  validates :user_id, uniqueness: { scope: [:name, :code, :cargapp_model_id] }
  validates :code, uniqueness: { scope: [:name, :user_id, :cargapp_model_id] }
end
