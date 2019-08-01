# frozen_string_literal: true

class Api::V1::UserRolesController < ApplicationController
  before_action :set_user_role, only: %i[show update destroy]
  protect_from_forgery with: :null_session # Temporary

  # GET /user_roles
  # GET /user_roles.json
  def index
    @user_roles = UserRole.all

    render json: @user_roles
  end

  def active
    @user_roles = UserRole.where(active: true)

    render json: @user_roles
  end

  # GET /user_roles/1
  # GET /user_roles/1.json
  def show
    render json: @user_role
  end

  # POST /user_roles
  # POST /user_roles.json
  def create
    @user_role = UserRole.new(user_role_params)

    if @user_role.save
      render json: @user_role, status: :created, location: @user_role
      # 'user_role was successfully created.'
    else
      render json: @user_role.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_roles/1
  # PATCH/PUT /user_roles/1.json
  def update
    if @user_role.update(user_role_params)
        render json: @user_role
        # 'user_role was successfully updated.'
    else
        render json: @user_role.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_roles/1
  # DELETE /user_roles/1.json
  def destroy
    @user_role.destroy
  end

    private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_role
    @user_role = UserRole.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_role_params
    params.require(:user_role).permit(:role_id, :user_id, :admin_id, :active)
  end
end
