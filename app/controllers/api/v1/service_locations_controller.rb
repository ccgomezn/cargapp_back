class Api::V1::ServiceLocationsController < ApplicationController
  before_action :set_service_location, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  # GET /service_locations
  # GET /service_locations.json
  def index
    @service_locations = ServiceLocation.all
    render json: @service_locations
  end

  def active
    @service_locations = ServiceLocation.where(active: true)
    render json: @service_locations
  end

  def me
    @service_locations = @user.service_locations
    render json: @service_locations
  end

  # GET /service_locations/1
  # GET /service_locations/1.json
  def show
    render json: @service_locations
  end

  # POST /service_locations
  # POST /service_locations.json
  def create
    @service_location = ServiceLocation.new(service_location_params)
    if @service_location.save
      render  json: @service_location, status: :created, location: @service_location
    else
      render json: @service_location.errors, status: :unprocessable_entity
    end    
  end

  # PATCH/PUT /service_locations/1
  # PATCH/PUT /service_locations/1.json
  def update
      if @service_location.update(service_location_params)
        render json: @service_location, status: :ok, location: @service_location
      else
        render json: @service_location.errors, status: :unprocessable_entity
      end    
  end

  # DELETE /service_locations/1
  # DELETE /service_locations/1.json
  def destroy
    @service_location.destroy
  end

  private

    def set_user
      @user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      permissions()
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

        if if_super()
          has_permission = true
        end

        if has_permission
          true
        else
          response = { response: "Does not have permissions" }
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
          response = { response: "Does not have permissions" }
          render json: response, status: :unprocessable_entity
        end
      end
    end

    def if_super
      @if_super = (User.is_super?(@user) if @user) || false
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_service_location
      @service_location = ServiceLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_location_params
      params.require(:service_location).permit(:longitude, :latitude, :city_id, :user_id, :service_id, :active)
    end
end
