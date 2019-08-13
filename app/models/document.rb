class Document < ApplicationRecord
  belongs_to :document_type
  belongs_to :statu
  belongs_to :user
  has_one_attached :file
end
