class ServiceLocationsController < ApplicationController
  before_action :set_service_location, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /service_locations
  # GET /service_locations.json
  def index
    @service_locations = ServiceLocation.all
  end

  # GET /service_locations/1
  # GET /service_locations/1.json
  def show
  end

  # GET /service_locations/new
  def new
    @service_location = ServiceLocation.new
  end

  # GET /service_locations/1/edit
  def edit
  end

  # POST /service_locations
  # POST /service_locations.json
  def create
    @service_location = ServiceLocation.new(service_location_params)

    respond_to do |format|
      if @service_location.save
        format.html { redirect_to @service_location, notice: 'Service location was successfully created.' }
        format.json { render :show, status: :created, location: @service_location }
      else
        format.html { render :new }
        format.json { render json: @service_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /service_locations/1
  # PATCH/PUT /service_locations/1.json
  def update
    respond_to do |format|
      if @service_location.update(service_location_params)
        format.html { redirect_to @service_location, notice: 'Service location was successfully updated.' }
        format.json { render :show, status: :ok, location: @service_location }
      else
        format.html { render :edit }
        format.json { render json: @service_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_locations/1
  # DELETE /service_locations/1.json
  def destroy
    @service_location.destroy
    respond_to do |format|
      format.html { redirect_to service_locations_url, notice: 'Service location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_location
      @service_location = ServiceLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_location_params
      params.require(:service_location).permit(:longitude, :latitude, :city_id, :user_id, :service_id, :active)
    end
end
