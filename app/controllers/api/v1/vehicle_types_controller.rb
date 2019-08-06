class Api::V1::VehicleTypesController < ApplicationController
  before_action :set_vehicle_type, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary

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
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle_type
      @vehicle_type = VehicleType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehicle_type_params
      params.require(:vehicle_type).permit(:name, :code, :icon, :description, :active)
    end
end
