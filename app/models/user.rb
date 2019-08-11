class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :cargapp_integrations
  has_many :companies
  has_many :tickets
  has_many :documents
  has_one :profile

  has_many :access_grants,
         class_name: 'Doorkeeper::AccessGrant',
         foreign_key: :resource_owner_id,
         dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
         class_name: 'Doorkeeper::AccessToken',
         foreign_key: :resource_owner_id,
         dependent: :delete_all # or :destroy if you need callbacks


  def is_super?
    state = false
    roles.each do |role|
      state = true if role.name.eql?(ENV['SUPER_N'] || ENV['SUPER_C']) && user_roles.find_by(role_id: role.id, active: true)
    end
    state
  end

  private
  def self.is_super?(user)
    state = false
    user.roles.each do |role|
      state = true if role.name.eql?(ENV['SUPER_N'] || ENV['SUPER_C']) && user.user_roles.find_by(role_id: role.id, active: true)
    end
    state    
    # User is admin ? User.is_admin?(current_user)
  end
end
