# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  # before_action :doorkeeper_authorize!, except: %i[create login show update email_verify phone_verify]

  swagger_controller :users, 'User Management'

  swagger_api :index do
    summary 'Fetches all User items'
    notes 'This lists all the users'
  end

  swagger_api :create do
    summary 'Creates a new User'
    param :form, :email, :string, :required, 'Email'
    param :form, :password, :string, :required, 'Password'
    param :form, :password_confirmation, :string, :required, 'Password confirmation'
    param :form, :phone_number, :string, :optional, 'Phone number'
    response :unauthorized
    response :not_acceptable
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      head(:unprocessable_entity)
    end
  end

  def index
    @users = User.all
    render json: @users
    # render json: { "name": 'hola'}, status: :created
  end

  private

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
