class Vehicle < ApplicationRecord
  belongs_to :vehicle_type
  belongs_to :owner_document_type, :class_name => 'DocumentType', optional: true
  belongs_to :user
end
