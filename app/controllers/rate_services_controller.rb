class RateServicesController < ApplicationController
  before_action :set_rate_service, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /rate_services
  # GET /rate_services.json
  def index
    @rate_services = RateService.all
  end

  # GET /rate_services/1
  # GET /rate_services/1.json
  def show
  end

  # GET /rate_services/new
  def new
    @rate_service = RateService.new
  end

  # GET /rate_services/1/edit
  def edit
  end

  # POST /rate_services
  # POST /rate_services.json
  def create
    @rate_service = RateService.new(rate_service_params)

    respond_to do |format|
      if @rate_service.save
        format.html { redirect_to @rate_service, notice: 'Rate service was successfully created.' }
        format.json { render :show, status: :created, location: @rate_service }
      else
        format.html { render :new }
        format.json { render json: @rate_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rate_services/1
  # PATCH/PUT /rate_services/1.json
  def update
    respond_to do |format|
      if @rate_service.update(rate_service_params)
        format.html { redirect_to @rate_service, notice: 'Rate service was successfully updated.' }
        format.json { render :show, status: :ok, location: @rate_service }
      else
        format.html { render :edit }
        format.json { render json: @rate_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rate_services/1
  # DELETE /rate_services/1.json
  def destroy
    @rate_service.destroy
    respond_to do |format|
      format.html { redirect_to rate_services_url, notice: 'Rate service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate_service
      @rate_service = RateService.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rate_service_params
      params.require(:rate_service).permit(:service_point, :driver_point, :point, :service_id, :user_id, :driver_id, :active)
    end
end
