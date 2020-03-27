# frozen_string_literal: true

class Coupon < ApplicationRecord
  belongs_to :cargapp_model
  belongs_to :user
  belongs_to :company
  validates :name, :code, uniqueness: true
  validates :name, :code, presence: true
  validates :user_id, uniqueness: { scope: %i[name code cargapp_model_id] }
  validates :code, uniqueness: { scope: %i[name user_id cargapp_model_id] }
  has_one_attached :image

  before_create :default_values
  def default_values
    self.name = name.capitalize
  end
end
