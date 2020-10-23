class RateService < ApplicationRecord
  belongs_to :service
  belongs_to :user
  belongs_to :driver, :class_name => 'User', optional: true

  # Create codes of user
  before_create :build_user
  def build_user
    self.active ||= false
  end
end
