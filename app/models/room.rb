class Room < ApplicationRecord
  belongs_to :service, optional: true
  belongs_to :user
end
