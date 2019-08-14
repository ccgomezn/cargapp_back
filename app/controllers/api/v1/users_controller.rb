# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!, except: %i[create login email_verify]
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

  def email_verify
    user = User.find_by(user_email_params)
    if user
      user = { email: true, message: "exist"}
      render json: user, status: :ok
    else
      user = { email: false, message: "does not exist"}
      render json: user, status: :found
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
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

  private

  def set_show_user
    @user = User.find(params[:id])
  end

  def set_user
    @user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def user_email_params
    params.require(:user).permit(:email)
  end

  def user_phone_params
    params.require(:user).permit(:phone_number)
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
    # params.require(:user).permit(:email, :password, :password_confirmation, :username, :phone_number, :driver_referal_code)
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:email, :username, :phone_number, :driver_referal_code)
  end
end
