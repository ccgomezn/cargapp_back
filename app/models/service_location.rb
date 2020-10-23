class ServiceLocation < ApplicationRecord
  belongs_to :city
  belongs_to :user
  belongs_to :service
end
