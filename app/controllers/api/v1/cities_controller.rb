# frozen_string_literal: true

class Api::V1::CitiesController < ApplicationController
  before_action :set_city, only: %i[show edit update destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  swagger_controller :cities, 'Cities Management'

  swagger_api :index do
    summary 'Fetches all City items'
    notes 'This lists all the cities'
  end

  swagger_api :active do
    summary 'Fetches all active City items'
    notes 'This lists all the active cities'
  end

  swagger_api :create do
    summary 'Creates a new City'
    param :form, 'city[name]', :string, :required, 'Name'
    param :form, 'city[code]', :string, :required, 'Code'
    param :form, 'city[description]', :string, :required, 'Description'
    param :form, 'city[state_id]', :integer, :required, 'State Id related to City'
    param :form, 'city[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing City'
    param :path, :id, :integer, :required, 'City Id'
    param :form, 'city[name]', :string, :optional, 'Name'
    param :form, 'city[code]', :string, :optional, 'Code'
    param :form, 'city[description]', :string, :optional, 'Description'
    param :form, 'city[state_id]', :integer, :optional, 'State Id related to City'
    param :form, 'city[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary 'Deletes an existing City'
    param :path, :id, :integer, :optional, 'City Id'
    response :unauthorized
    response :not_found
  end

  swagger_api :show do
    summary 'Fetches detailed City items'
    param :path, :id, :integer, :optional, 'City Id'
    notes 'This lists detailed cities'
  end

  # GET /cities
  # GET /cities.json
  def index
    @cities = City.all

    render json: @cities
  end

  def active
    @cities = City.where(active: true)

    render json: @cities
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
    render json: @city
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(city_params)

    if @city.save
      render json: @city, status: :created, location: @city
      # 'city model was successfully created.'
    else
      render json: @city.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    if @city.update(city_params)
      render json: @city
      # 'city was successfully updated.'
    else
      render json: @city.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city.destroy
  end

  private

  def set_user
    @user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    permissions
  end

  def permissions
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

      has_permission = true if if_super

      if has_permission
        true
      else
        response = { response: 'Does not have permissions' }
        render json: response, status: :unprocessable_entity
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
        response = { response: 'Does not have permissions' }
        render json: response, status: :unprocessable_entity
      end
    end
  end

  def if_super
    @if_super = (User.is_super?(@user) if @user) || false
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_city
    @city = City.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def city_params
    params.require(:city).permit(:name, :code, :description, :state_id,
                                 :active, :lon, :lat, :radius)
  end
end
