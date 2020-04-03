class DocumentType < ApplicationRecord
    validates :name, :code, uniqueness: true
    validates :name, :code, presence: true
    validates :code, uniqueness: { scope: %i[category] }
    validates :name, uniqueness: { scope: %i[category] }
    
    before_create :default_values
    def default_values
        self.active ||= false
    end
end
