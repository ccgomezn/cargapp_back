class Permission < ApplicationRecord
  belongs_to :role
  belongs_to :cargapp_model
  belongs_to :user
  validates :role_id, uniqueness: { scope: [:cargapp_model_id, :action, :allow] }
  # validates :role_id, uniqueness: { scope: [:cargapp_model_id, :action, :method] }
end
