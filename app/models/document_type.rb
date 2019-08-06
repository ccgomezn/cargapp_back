class DocumentType < ApplicationRecord
    validates :name, :code, uniqueness: true
    validates :name, :code, presence: true
end
