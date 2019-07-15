class Parameter < ApplicationRecord
  belongs_to :user
  belongs_to :cargapp_model
  validates :name, :code, uniqueness: true
  validates :name, :code, presence: true
  validates :cargapp_model_id, uniqueness: { scope: [:value] }
end
