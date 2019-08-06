class CargappIntegration < ApplicationRecord
  belongs_to :user
  validates :name, uniqueness: { scope: [:provider, :code, :client_id, :token, :api_key] }
  validates :code, presence: true
end
