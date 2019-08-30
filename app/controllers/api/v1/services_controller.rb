class Api::V1::ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :set_user
  before_action :doorkeeper_authorize!

  # GET /services
  # GET /services.json
  def index
    @services = Service.all
    render json: @services
  end

  def active
    @services = Service.where(active: true)
    render json: @services
  end
  
  def me
    @services = @user.services
    render json: @services
  end
  # GET /services/1
  # GET /services/1.json
  def show
    render json: @service
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)
    if @service.save
      render json: @service, status: :created, location: @service
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
      if @service.update(service_params)
        render json: @service, status: :ok, location: @service
      else
        render json: @service.errors, status: :unprocessable_entity
      end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
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
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:name, :origin, :origin_city_id, :origin_address, :origin_longitude, :origin_latitude, :destination, :destination_city_id, :destination_address, :destination_latitude, :destination_longitude, :price, :description, :note, :user_id, :company_id, :user_driver_id, :user_receiver_id, :vehicle_type_id, :vehicle_id, :statu_id, :expiration_date, :contact, :active)
    end
end
