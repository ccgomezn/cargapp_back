class Api::V1::VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

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
