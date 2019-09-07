# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!, except: %i[create login email_verify phone_verify validate_number]
  before_action :set_user

  swagger_controller :users, 'User Management'

  swagger_api :index do
    summary 'Fetches all User items'
    notes 'This lists all the users'
  end

  swagger_api :create do
    summary 'Creates a new User'
    param :form, 'user[email]', :string, :required, 'Email'
    param :form, 'user[password]', :string, :required, 'Password'
    param :form, 'user[password_confirmation]', :string, :required, 'Password confirmation'
    param :form, 'user[phone_number]', :string, :optional, 'Phone number'
    response :unauthorized
    response :not_acceptable
  end

  def index
    @users = User.all
    render json: @users
    # render json: { "name": 'hola'}, status: :created
  end

  def active
    @users = User.where(active: true)
    render json: @users
    # render json: { "name": 'hola'}, status: :created
  end

  def email_verify
    user = User.find_by(user_email_params)
    if user && user.email.eql?(params[:user][:email])
      user = { email: true, message: "exist"}
      render json: user, status: :ok
    else
      user = { email: false, message: "does not exist"}
      render json: user, status: :found
    end
  end

  def phone_verify
    user = User.find_by(user_phone_params)
    puts '---------------------'
    puts user.to_json
    if user && user.phone_number.eql?(params[:user][:phone_number])
      user = { phone_number: true, message: "exist"}
      render json: user, status: :ok
    else
      user = { phone_number: false, message: "does not exist"}
      render json: user, status: :found
    end
  end

  # Falta en la migracion agregar la confirmacion de cuentas del devise
  def validate_number
    user = User.find_by(user_verify_phone_params)
    if user
      message = if user.active && user.mobile_verify
                  'it has already been validated'
                else
                  'user validate'
                end
      user.update(mobile_verify: true, active: true, confirmed_at: Time.new)
      render json: user = { user: user, message: message }
    else
      user = { user: user, message: 'not found' }
      render json: user, status: :found
    end
  end

  def active
    if @user
      @user.update(online: params['user']['online'])
      render json: @user, status: :ok
    else
      head(:unprocessable_entity)
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      profile()
      render json: @user, status: :created
    else
      head(:unprocessable_entity)
    end
  end

  def login
    client = OAuth2::Client.new(ENV['APP'], ENV['SECREPP_APP'], :site => ENV['URL'])
    begin
      token = client.password.get_token(params["user"]["email"], params["user"]["password"])
      # token_reponse = { token: token, user: @user}
      render json: token, status: :ok
    rescue OAuth2::Error => e
      reponse = { user: nil, message: "La contraseña o el correo es incorrecto" }
      render json: reponse, status: :unauthorized
    end
  end

  def update_password
    # @user = User.find_by(email: params["user"]["email"]) || User.find_by(phone_number: params["user"]["phone_number"])
    if @user.valid_password?(params[:user][:current_password])
      if @user.update(user_password_params)
        # Sign in the user by passing validation in case their password changed
        bypass_sign_in(@user)
        render json: @user, status: :ok
      else
        head(:unprocessable_entity)
      end
    else
      object_instance = {
        user: @user,
        message: 'incorrect current password '
      }
      render json: object_instance, status: :not_modified
    end
  end

  def me
    if @user
      roles = []
      permissions = []
      @user.user_roles.each do |role|
        permissions = []
        role.role.permissions.each do |permission|
          obj = {
            id: permission.id,
            cargapp_model: permission.cargapp_model.as_json(only: %i[name id]),
            action: permission.action, method: permission.method,
            allow: permission.allow, user_id: permission.user_id,
            active: permission.active, created_at: permission.created_at,
            updated_at: permission.updated_at
          }
          permissions << obj
        end

        obj = {
          id: role.id, role_id: role.role.id, admin_id: role.admin_id, 
          name: role.role.name, description: role.role.description,
          active: role.active && role.role.active,
          created_at: role.created_at, updated_at: role.updated_at,
          permissions: permissions
        }
        roles << obj
      end

      @obj = {
        user: @user,
        roles: roles
      }

      render json: @obj, status: :ok
    else
      head(:unprocessable_entity)
    end
  end

  def show
    @user_id = User.find_by(id: set_show_user)
    render json: @user_id, status: :ok
  end

  def truora_users
    uri = URI.parse("#{ENV['URL_TRUORA']}/checks")
    request = Net::HTTP::Get.new(uri)
    request["Truora-Api-Key"] = ENV['TOKEN_TRUORA']

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    render json: response.body
  end

  # Send { "user": { "id": 1 }  }
  def truora_user
    uri = URI.parse("#{ENV['URL_TRUORA']}/checks/#{params[:id]}/details")
    request = Net::HTTP::Get.new(uri)
    request["Truora-Api-Key"] = ENV['TOKEN_TRUORA']

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    render json: response.body
  end

  def truora_check_user
    user = User.find_by(check_user_params)
    if user.identification.eql?(user.profile ? user.profile.document_id.to_s : nil)
      if user.identification
        vehicle = user.vehicles.where(active: true).first
        if vehicle
          check = check_user(user, vehicle)
        end
      end
      check = JSON.parse(check.to_s)

      #puts check['check']['check_id']
      #user.update(check_id: check['check']['check_id'] )

      response =  {
        menssaje: "in process of validation",
        check: check,
        user: user
      }

      render json: response
    else
      response =  {
        menssaje: "validate your identification",
        user_identification: user.identification,
        profile_document: user.profile ? user.profile.document_id : nil
      }
      render json: response
    end
  end

  def check_user(user, vehicle)
    uri = URI.parse("#{ENV['URL_TRUORA']}/checks")
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(country: 'co', type: 'vehicle', national_id: user.identification, license_plate: vehicle.plate, force_creation: true )
    request["Truora-Api-Key"] = ENV['TOKEN_TRUORA']

    req_options = {
        use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
    end

    response.body 
  end

  def truora_check_user_test
    uri = URI.parse("#{ENV['URL_TRUORA']}/checks")
    request = Net::HTTP::Post.new(uri)
    # request.set_form_data(country: 'co', type: 'person', national_id: '36835533', force_creation: true )
    # request.set_form_data(country: 'co', type: 'vehicle', national_id: '36835533', license_plate: 'VZB227',force_creation: true )
    request["Truora-Api-Key"] = ENV['TOKEN_TRUORA']

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    render json: response.body
  end

  private

  def profile
    doct_type = DocumentType.find_by(code: ENV['DOC_TYPE_CC'])
    # Formatear el username
    profile = Profile.create(user_id: @user.id,
      firt_name: params[:user][:username],
      document_type_id: doct_type.id, 
      document_id: @user.identification,
      phone: @user.phone_number 
    )
    profile.save
  end

  def set_show_user
    @user = User.find(params[:id])
  end

  def set_user
    @user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def user_email_params
    params.require(:user).permit(:email)
  end

  def check_user_params
    params.require(:user).permit(:id)
  end

  def user_phone_params
    params.require(:user).permit(:phone_number)
  end

  def user_verify_phone_params
    params.require(:user).permit(:phone_number, :mobile_code)
  end

  def user_password_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_login_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :email)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :identification, :phone_number)
    #params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:email, :username, :phone_number, :driver_referal_code)
  end
end
