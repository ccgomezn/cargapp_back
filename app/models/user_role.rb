class UserRole < ApplicationRecord
  belongs_to :role
  belongs_to :user
  belongs_to :admin, :class_name => 'User', optional: true
  validates :user_id, uniqueness: { scope: [:role_id] }
end
