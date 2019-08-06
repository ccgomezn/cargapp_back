class Company < ApplicationRecord
  belongs_to :load_type
  belongs_to :user
end
