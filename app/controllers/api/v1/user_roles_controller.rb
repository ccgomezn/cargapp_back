# frozen_string_literal: true

class Api::V1::UserRolesController < ApplicationController
  before_action :set_user_role, only: %i[show update destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!

  swagger_controller :userRoles, 'User and Roles relation Management'

  swagger_api :index do
    summary 'Fetches all User-Roles items'
    notes 'This lists all the user-roles'
  end

  swagger_api :active do
    summary 'Fetches all active User-Role items'
    notes 'This lists all the active users-roles'
  end

  swagger_api :create do
    summary 'Creates a new User-Role'
    param :form, 'user_role[role_id]', :integer, :required, 'Role Id'
    param :form, 'user_role[user_id]', :integer, :required, 'User Id'
    param :form, 'user_role[admin_id]', :integer, :required, 'Admin Id responsible of creation'
    param :form, 'user_role[active]', :boolean, :required, 'Activation state'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing User-Role'
    param :path, :id, :integer, :required, "User-Role Id"
    param :form, 'user_role[role_id]', :integer, :optional, 'Role Id'
    param :form, 'user_role[user_id]', :integer, :optional, 'User Id'
    param :form, 'user_role[admin_id]', :integer, :optional, 'Admin Id responsible of creation'
    param :form, 'user_role[active]', :boolean, :optional, 'Activation state'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing User-Role"
    param :path, :id, :integer, :optional, "User-Role Id"
    response :unauthorized
    response :not_found
  end


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
