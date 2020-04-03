class FavoriteRoute < ApplicationRecord
  belongs_to :origin_city, :class_name => 'City', optional: true
  belongs_to :destination_city, :class_name => 'City', optional: true
  belongs_to :user

  validates :user_id, :origin_city_id, :destination_city_id, presence: true
  validates :user_id, uniqueness: { scope: %i[origin_city_id destination_city_id] }

  before_create :default_values
  def default_values
    self.active ||= false
  end
end
