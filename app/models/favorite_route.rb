class FavoriteRoute < ApplicationRecord
  belongs_to :origin_city, :class_name => 'City', optional: true
  belongs_to :destination_city, :class_name => 'City', optional: true
  belongs_to :user
end
