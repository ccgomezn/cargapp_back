class Country < ApplicationRecord
    validates :name, :code, :cioc, uniqueness: true
    validates :name, :code, :cioc, presence: true
end
