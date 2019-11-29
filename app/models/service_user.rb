class ServiceUser < ApplicationRecord
  belongs_to :service
  belongs_to :user
  belongs_to :vehicle, optional: true
end
