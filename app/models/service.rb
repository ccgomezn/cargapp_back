class Service < ApplicationRecord
  belongs_to :origin_city, :class_name => 'City', optional: true
  belongs_to :destination_city, :class_name => 'City', optional: true
  belongs_to :user
  belongs_to :company, optional: true
  belongs_to :user_driver, :class_name => 'User', optional: true
  belongs_to :user_receiver, :class_name => 'User', optional: true
  belongs_to :vehicle_type, optional: true
  belongs_to :vehicle, optional: true
  belongs_to :statu
  has_one :room
end