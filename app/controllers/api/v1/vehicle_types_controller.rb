class Api::V1::VehicleTypesController < ApplicationController
  before_action :set_vehicle_type, only: %i[show edit update destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  swagger_controller :vehicleTypes, 'Vehicle Types Management'

  swagger_api :index do
    summary 'Fetches all Vehicle Types items'
    notes 'This lists all the vehicle types'
  end

  swagger_api :active do
    summary 'Fetches all active Vehicle Types items'
    notes 'This lists all the active vehicle types'
  end

  swagger_api :create do
    summary 'Creates a new Vehicle Type'
    param :form, 'vehicle_type[name]', :string, :required, 'Name'
    param :form, 'vehicle_type[code]', :string, :required, 'Code'
    param :form, 'vehicle_type[description]', :string, :required, 'Description'
    param :form, 'vehicle_type[icon]', :string, :required, 'Icon'
    param :form, 'vehicle_type[active]', :boolean, :required, 'Activation State'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Vehicle Type'
    param :path, :id, :integer, :required, "Vehicle Type Id"
    param :form, 'vehicle_type[name]', :string, :optional, 'Name'
    param :form, 'vehicle_type[code]', :string, :optional, 'Code'
    param :form, 'vehicle_type[description]', :string, :optional, 'Description'
    param :form, 'vehicle_type[icon]', :string, :optional, 'Icon'
    param :form, 'vehicle_type[active]', :boolean, :optional, 'Activation State'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Vehicle Type"
    param :path, :id, :integer, :optional, "Vehicle Type Id"
    response :unauthorized
    response :not_found
  end

  swagger_api :show do
    summary "Show a Vehicle Type"
    param :path, :id, :integer, :optional, "Vehicle Type Id"
    response :unauthorized
    response :not_found
  end

  # GET /vehicle_types
  # GET /vehicle_types.json
  def index
    @vehicle_types = VehicleType.all

    render json: @vehicle_types
  end

  def active
    @vehicle_types = VehicleType.where(active: true)

    render json: @vehicle_types
  end

  # GET /vehicle_types/1
  # GET /vehicle_types/1.json
  def show
    render json: @vehicle_type
  end

  # POST /vehicle_types
  # POST /vehicle_types.json
  def create
    @vehicle_type = VehicleType.new(vehicle_type_params)

    if @vehicle_type.save
      render json: @vehicle_type, status: :created, location: @vehicle_type
      # 'vehicle_type was successfully created.'
    else
      render json: @vehicle_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vehicle_types/1
  # PATCH/PUT /vehicle_types/1.json
  def update
    if @vehicle_type.update(vehicle_type_params)
      render json: @vehicle_type
      # 'vehicle_type was successfully updated.'
    else
      render json: @vehicle_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vehicle_types/1
  # DELETE /vehicle_types/1.json
  def destroy
    @vehicle_type.destroy
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
      role = Role.find_by(name: 'USER', active: true)
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
  def set_vehicle_type
    @vehicle_type = VehicleType.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vehicle_type_params
    params.require(:vehicle_type).permit(:name, :code, :icon, :description, :active)
  end
end
