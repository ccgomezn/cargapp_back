# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles, dependent: :destroy
  has_many :cargapp_integrations, dependent: :destroy
  has_many :companies, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :challenges, dependent: :destroy
  has_many :user_challenges, dependent: :destroy
  has_many :user_coupons, dependent: :destroy
  has_many :user_prizes, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :user_payment_methods, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :service_documents, dependent: :destroy
  has_many :favorite_routes, dependent: :destroy
  has_many :cargapp_ads, dependent: :destroy
  has_many :user_locations, dependent: :destroy
  has_many :service_locations, dependent: :destroy
  has_many :bank_accounts, dependent: :destroy
  has_many :cargapp_payments, dependent: :destroy
  has_many :payments, dependent: :destroy
  validates :phone_number, presence: true
  validates :phone_number, uniqueness: true
  has_many :rooms, dependent: :destroy
  has_many :room_users, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :service_users, dependent: :destroy
  has_many :coupons, dependent: :destroy
  has_many :vehicle_bank_accounts, dependent: :destroy

  # has_many :payment_methods, dependent: :destroy

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

  # Create codes of user
  before_create :build_user
  def build_user
    number_randon = [(0..9)].map(&:to_a).flatten
    code = [('A'..'Z'), (0..9)].map(&:to_a).flatten
    referal_code = (0...8).map { code[rand(code.length)] }.join
    pin = (0...4).map { number_randon[rand(number_randon.length)] }.join
    mobile_code = (0...4).map { number_randon[rand(number_randon.length)] }.join
    # password la cedula
    self.mobile_code ||= mobile_code
    self.referal_code ||= referal_code
    self.user_referal_code ||= 'N/A'
    self.pin ||= pin
    self.mobile_verify ||= false
    self.online ||= false
    self.active ||= false
  end

  def twillio_error(data)
    $error_tw = data
  end

  after_create :build_profile
  def build_profile
    @client = Twilio::REST::Client.new ENV['TWILLIO_ACCOUNT_SID'], ENV['TWILLIO_AUT_TOKEN']
    @client.api.account.messages.create(from: ENV['TWILLIO_FROM'], to: "+#{phone_number}", body: "Hola tu codigo de verificacion Cargapp es: #{mobile_code}")
  rescue Twilio::REST::RestError => e
    twillio_error(true)
  end

  def send_reset_password_instructions
    # Email
    # token = set_reset_password_token

    # Phone
    number_randon = [(0..9)].map(&:to_a).flatten
    token = (0...6).map { number_randon[rand(number_randon.length)] }.join

    send_reset_password_instructions_notification(token)
    token
  end

  private

  def self.permissions(user)
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

      has_permission = true if @if_super

      if has_permission
        true
      else
        response = { response: 'Does not have permissions' }
        # render json: response, status: :unprocessable_entity
        # render_bind type: { json: 'ss'}
      end
    else
      role = Role.find_by(name: 'USER', active: true)
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
        response = { response: 'Does not have permissions' }
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
      next unless role.name.eql?(ENV['SUPER_N'] || ENV['SUPER_C'])

      state = true if user.user_roles.find_by(role_id: role.id, active: true)
    end
    state
  end
end
