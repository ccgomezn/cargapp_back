class Service < ApplicationRecord
  belongs_to :origin_city, :class_name => 'City', optional: true
  belongs_to :destination_city, :class_name => 'City', optional: true
  belongs_to :user
  belongs_to :company, optional: true
  belongs_to :user_driver, :class_name => 'User', optional: true
  belongs_to :user_receiver, :class_name => 'User', optional: true
  belongs_to :vehicle_type, optional: true
  belongs_to :vehicle, optional: true, optional: true #P
  belongs_to :statu
  has_one :cargapp_payment #P
  has_one :room, dependent: :destroy #P
  has_many :service_users, dependent: :destroy #P
  has_many :service_documents, dependent: :destroy #P
  has_one :rate_service, dependent: :destroy #P

  before_create :default_values
  before_save :default_values
  def default_values
    self.origin = self.origin.capitalize
    self.destination = self.destination.capitalize
    self.name = %'#{self.origin}-#{self.destination}'

    if self.statu_id == ENV['STATUS_END_ID']
      #distance = 
      #duration = 
      puts '-----------'
    end
  end
end