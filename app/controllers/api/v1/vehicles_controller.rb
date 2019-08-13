class Api::V1::VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user


  swagger_controller :vehicles, 'Vehicles Management'

  swagger_api :index do
    summary 'Fetches all Vehicle items'
    notes 'This lists all the Vehicles'
  end

  swagger_api :active do
    summary 'Fetches all active Vehicle items'
    notes 'This lists all the active Vehicles'
  end

  swagger_api :create do
    summary 'Creates a new Vehicle'
    param :form, :brand, :string, :required, 'Brand'
    param :form, :model, :string, :required, 'Model'
    param :form, :model_year, :string, :required, 'Model Year'
    param :form, :color, :string, :required, 'Color'
    param :form, :plate, :string, :required, 'Plate'
    param :form, :chassis, :string, :required, 'Chassis'
    param :form, :owner_vehicle, :string, :required, 'Id of the vehicles owner'
    param :form, :vehicle_type_id, :integer, :required, 'Id of the vehicle type'
    param :form, :owner_document_type_id, :integer, :required, 'Document type of the owner'
    param :form, :owner_document_id, :integer, :required, 'Id of the driver'
    param :form, :user_id, :integer, :required, 'Id of the user'
    param :form, :active, :boolean, :required, 'Activation state'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Vehicle'
    param :path, :id, :integer, :required, "Vehicle Id"
    param :form, :brand, :string, :optional, 'Brand'
    param :form, :model, :string, :optional, 'Model'
    param :form, :model_year, :string, :optional, 'Model Year'
    param :form, :color, :string, :optional, 'Color'
    param :form, :plate, :string, :optional, 'Plate'
    param :form, :chassis, :string, :optional, 'Chassis'
    param :form, :owner_vehicle, :string, :optional, 'Id of the vehicles owner'
    param :form, :vehicle_type_id, :integer, :optional, 'Id of the vehicle type'
    param :form, :owner_document_type_id, :integer, :optional, 'Document type of the owner'
    param :form, :owner_document_id, :integer, :optional, 'Id of the driver'
    param :form, :user_id, :integer, :optional, 'Id of the user'
    param :form, :active, :boolean, :optional, 'Activation state'
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Vehicle"
    param :path, :id, :integer, :optional, "Vehicle Id"
    response :unauthorized
    response :not_found
  end


  # GET /vehicles
  # GET /vehicles.json
  def index
    @vehicles = Vehicle.all

    render json: @vehicles
  end

  def active
    @vehicles = Vehicle.where(active: true)

    render json: @vehicles
  end

  def me
    @vehicles = @user.vehicles
    
    render json: @vehicles
  end

  # GET /vehicles/1
  # GET /vehicles/1.json
  def show
    render json: @vehicle
  end

  # POST /vehicles
  # POST /vehicles.json
  def create
    @vehicle = Vehicle.new(vehicle_params)

    if @vehicle.save
      render json: @vehicle, status: :created, location: @vehicle
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vehicles/1
  # PATCH/PUT /vehicles/1.json
  def update
    if @vehicle.update(vehicle_params)
      render json: @vehicle
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vehicles/1
  # DELETE /vehicles/1.json
  def destroy
    @vehicle.destroy
  end

  private
    def set_user
      @user = User.all.first #User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehicle_params
      params.require(:vehicle).permit(:brand, :model, :model_year, :color, :plate, :chassis, :owner_vehicle, :vehicle_type_id, :owner_document_type_id, :owner_document_id, :user_id, :active)
    end
end
