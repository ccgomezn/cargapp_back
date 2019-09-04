class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :cargapp_integrations
  has_many :companies
  has_many :tickets
  has_many :vehicles
  has_many :documents
  has_one :profile
  has_many :challenges
  has_many :user_challenges
  has_many :user_coupons
  has_many :user_prizes
  has_many :reports
  has_many :user_payment_methods
  has_many :services
  has_many :service_documents
  has_many :favorite_routes
  has_many :cargapp_ads
  has_many :user_locations
  has_many :service_locations
  has_many :bank_accounts
  has_many :cargapp_payments
  has_many :payments
  

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

  def self.permissions(user)
    puts '------------------'
    puts user 
    @user = user
    if @user
      has_permission = false
      @user.roles.where(active: true).each do |role|
        next if role.permissions.where(active: true).empty?
        role.permissions.where(active: true).each do |permission|
          if (permission.cargapp_model.value.eql?(controller_name) && permission.active) && permission.action.eql?('all')
            has_permission = true
          elsif (permission.cargapp_model.value.eql?(controller_name) && permission.active) && permission.allow
            has_permission = true
          elsif (permission.cargapp_model.value.eql?(controller_name) && permission.active) && permission.action.eql?(action_name)
            has_permission = true
          end
        end
      end

      @if_super = (User.is_super?(@user) if @user) || false

      if @if_super
        has_permission = true
      end

      if has_permission
        true
      else
        response = { response: "Does not have permissions" }
        #render json: response, status: :unprocessable_entity
        # render_bind type: { json: 'ss'}
      end
    else
      role = Role.find_by(name: ENV['GUEST_N'], active: true)
      has_permission = false
      role.permissions.each do |permission|
        if (permission.cargapp_model.value.eql?(controller_name) && permission.active) && permission.action.eql?('all')
          has_permission = true
        elsif (permission.cargapp_model.value.eql?(controller_name) && permission.active) && permission.allow
          has_permission = true
        elsif (permission.cargapp_model.value.eql?(controller_name) && permission.active) && permission.action.eql?(action_name)
          has_permission = true
        end
      end

      if has_permission
        true
      else
        response = { response: "Does not have permissions" }
        render json: response, status: :unprocessable_entity
      end
    end
  end

  def if_super
    @if_super = (User.is_super?(@user) if @user) || false
  end

  def self.is_super?(user)
    state = false
    puts user.to_json
    user.roles.where(active: true).each do |role|
      if role.name.eql?(ENV['SUPER_N'] || ENV['SUPER_C'])
        if user.user_roles.find_by(role_id: role.id, active: true)
          state = true
        end
      end
    end
    state
  end
end
