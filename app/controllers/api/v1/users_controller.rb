# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  # protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!, except: %i[create login show update email_verify phone_verify]


  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      head(:unprocessable_entity)
    end
  end

  def index
    render json: { "name": 'hola'}, status: :created
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
