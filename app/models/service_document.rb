class ServiceDocument < ApplicationRecord
  belongs_to :service
  belongs_to :user
  belongs_to :document_type
  has_one_attached :document
end
