# frozen_string_literal: true

class Api::V1::RolesController < ApplicationController
  before_action :set_role, only: %i[show update destroy]
  protect_from_forgery with: :null_session # Temporary

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
