# frozen_string_literal: true

class Vehicle < ApplicationRecord
  belongs_to :vehicle_type
  belongs_to :owner_document_type, class_name: 'DocumentType', optional: true
  belongs_to :user
  has_many :vehicle_documents, dependent: :destroy
end
