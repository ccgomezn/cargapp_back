class Company < ApplicationRecord
  belongs_to :load_type
  belongs_to :user
  has_many :company_users
end
