# frozen_string_literal: true

class Api::V1::RolesController < ApplicationController
  before_action :set_role, only: %i[show update destroy]
  protect_from_forgery with: :null_session # Temporary
  #before_action :doorkeeper_authorize!

  swagger_controller :roles, 'Roles Management'

  swagger_api :index do
    summary 'Fetches all Roles items'
    notes 'This lists all the roles'
  end

  swagger_api :active do
    summary 'Fetches all active Roles items'
    notes 'This lists all the active roles'
  end

  swagger_api :create do
    summary 'Creates a new Role'
    param :form, 'role[name]', :string, :required, 'Name'
    param :form, 'role[code]', :string, :required, 'Code'
    param :form, 'role[description]', :string, :required, 'Description'
    param :form, 'role[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Role'
    param :path, :id, :integer, :required, "Role Id"
    param :form, 'role[name]', :string, :optional, 'Name'
    param :form, 'role[code]', :string, :optional, 'Code'
    param :form, 'role[description]', :string, :optional, 'Description'
    param :form, 'role[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Role"
    param :path, :id, :integer, :optional, "Role Id"
    response :unauthorized
    response :not_found
  end


  # GET /roles
  def index
    @roles = Role.all

    render json: @roles
  end

  def active
    @roles = Role.where(active: true)

    render json: @roles
  end

  # GET /roles/1
  def show
    render json: @role
  end

  # POST /roles
  def create
    @role = Role.new(role_params)

    if @role.save
      render json: @role, status: :created, location: @role
      # 'Role was successfully created.'
    else
      render json: @role.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /roles/1
  def update
    if @role.update(role_params)
      render json: @role
      # 'Role was successfully updated.'
    else
      render json: @role.errors, status: :unprocessable_entity
    end
  end

  # DELETE /roles/1
  def destroy
    @role.destroy
    # 'Role was successfully created.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def role_params
    params.require(:role).permit(:name, :code, :description, :active)
  end
end
