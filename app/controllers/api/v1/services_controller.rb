class Api::V1::ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :set_user
  before_action :doorkeeper_authorize!


  swagger_controller :service, 'Services Management'

  swagger_api :index do
    summary 'Fetches all Service items'
    notes 'This lists all the services'
  end

  swagger_api :active do
    summary 'Fetches all active Service items'
    notes 'This lists all the active services'
  end

  swagger_api :create do
    summary 'Creates a new Service'
    param :form, 'service[name]', :string, :required, 'Name'
    param :form, 'service[origin]', :string, :required, 'Origin'
    param :form, 'service[origin_city_id]', :integer, :required, 'Id of origin city'
    param :form, 'service[origin_address]', :string, :required, 'Address of origin'
    param :form, 'service[origin_longitude]', :string, :required, 'Longitude of origin'
    param :form, 'service[origin_latitude]', :string, :required, 'Latitude of origin'
    param :form, 'service[destination]', :string, :required, 'Destination'
    param :form, 'service[destination_city_id]', :integer, :required, 'Id of destination city'
    param :form, 'service[destination_address]', :string, :required, 'Address of destination'
    param :form, 'service[destination_latitude]', :string, :required, 'Latitude of destination'
    param :form, 'service[destination_longitude]', :string, :required, 'Longitude of destination'
    param :form, 'service[price]', :string, :required, 'Price'
    param :form, 'service[description]', :string, :required, 'Description'
    param :form, 'service[note]', :string, :required, 'Note'
    param :form, 'service[user_id]', :integer, :required, 'Id of user related'
    param :form, 'service[company_id]', :integer, :required, 'Id of company related'
    param :form, 'service[user_driver_id]', :integer, :optional, 'Id of driver related'
    param :form, 'service[user_receiver_id]', :integer, :optional, 'Id of receiver related'
    param :form, 'service[vehicle_type_id]', :integer, :optional, 'Id of vehicle type related'
    param :form, 'service[vehicle_id]', :integer, :optional, 'Id of vehicle related'
    param :form, 'service[statu_id]', :integer, :required, 'Id of status related'
    param :form, 'service[expiration_date]', :date, :required, 'Expiration date'
    param :form, 'service[contact]', :string, :required, 'Contact'
    param :form, 'state[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Service'
    param :path, :id, :integer, :required, "Service Id"
    param :form, 'service[name]', :string, :optional, 'Name'
    param :form, 'service[origin]', :string, :optional, 'Origin'
    param :form, 'service[origin_city_id]', :integer, :optional, 'Id of origin city'
    param :form, 'service[origin_address]', :string, :optional, 'Address of origin'
    param :form, 'service[origin_longitude]', :string, :optional, 'Longitude of origin'
    param :form, 'service[origin_latitude]', :string, :optional, 'Latitude of origin'
    param :form, 'service[destination]', :string, :optional, 'Destination'
    param :form, 'service[destination_city_id]', :integer, :optional, 'Id of destination city'
    param :form, 'service[destination_address]', :string, :optional, 'Address of destination'
    param :form, 'service[destination_latitude]', :string, :optional, 'Latitude of destination'
    param :form, 'service[destination_longitude]', :string, :optional, 'Longitude of destination'
    param :form, 'service[price]', :string, :optional, 'Price'
    param :form, 'service[description]', :string, :optional, 'Description'
    param :form, 'service[note]', :string, :optional, 'Note'
    param :form, 'service[user_id]', :integer, :optional, 'Id of user related'
    param :form, 'service[company_id]', :integer, :optional, 'Id of company related'
    param :form, 'service[user_driver_id]', :integer, :optional, 'Id of driver related'
    param :form, 'service[user_receiver_id]', :integer, :optional, 'Id of receiver related'
    param :form, 'service[vehicle_type_id]', :integer, :optional, 'Id of vehicle type related'
    param :form, 'service[vehicle_id]', :integer, :optional, 'Id of vehicle related'
    param :form, 'service[statu_id]', :integer, :optional, 'Id of status related'
    param :form, 'service[expiration_date]', :date, :optional, 'Expiration date'
    param :form, 'service[contact]', :string, :optional, 'Contact'
    param :form, 'state[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Service"
    param :path, :id, :integer, :optional, "Service Id"
    response :unauthorized
    response :not_found
  end

  swagger_api :me do
    summary "Shows mine existing Service"
    response :unauthorized
  end

  swagger_api :show do
    summary "Shows a Service"
    param :path, :id, :integer, :optional, "Service Id"
    response :unauthorized
    response :not_found
  end

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

  def filter
    start_price = params[:start_price].to_i.eql?(0) ? 10000 : params[:start_price].to_i
    end_price = params[:end_price].to_i.eql?(0) ? 100000 : params[:end_price].to_i
    origin = params[:origin] 
    destination = params[:destination]
    created_at = params[:created_at]
    vehicle_type = params[:vehicle_type]

    @services = Service.where('active = ? AND price >= ? AND price <= ?
      AND vehicle_type_id <= ?', true, start_price, end_price, vehicle_type)
      #.where('origin = ? AND destination = ? AND created_at >= ?', origin, destination, created_at)
      #.where(price: params[:start_price])
    render json: @services
  end
  
  def me
    @services = @user.services
    render json: @services
  end

  def find_driver
    user = User.find(params[:id])
    @services = Service.where(user_driver_id: user.id)
    render json: @services
  end

  def find_user
    user = User.find(id: params[:id])
    @services = Service.where(user_id: user.id)
    render json: @services
  end

  def find_company
    company = Company.find_by(id: params[:id], active: true)
    @services = Service.where(company_id: company.id)
    render json: @services
  end

  def find_receiver
    receiver = User.find_by(id: params[:id])
    @services = Service.where(user_receiver_id: receiver.id)
    render json: @services
  end

  def find_vehicle
    vehicle = User.find_by(id: params[:id])
    @services = Service.where(vehicle_id: vehicle.id)
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
