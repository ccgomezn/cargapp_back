class UserRole < ApplicationRecord
  belongs_to :role
  belongs_to :user
  belongs_to :admin, :class_name => 'User', optional: true
  validates :user_id, uniqueness: { scope: [:role_id] }
  
  before_create :build_user
  def build_user
    self.active ||= false
  end
end
