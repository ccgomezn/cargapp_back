class Api::V1::StatusController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary

  # GET /status
  # GET /status.json
  def index
    @status = Statu.all

    render json: @status
  end

  def active
    @status = Statu.where(active: true)

    render json: @status
  end

  # GET /status/1
  # GET /status/1.json
  def show
    render json: @statu
  end

  # POST /status
  # POST /status.json
  def create
    @statu = Statu.new(status_params)
    
    if @statu.save
      render json: @statu, status: :created, location: @statu
      # 'Status was successfully created.'
    else
      render json: @statu.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /status/1
  # PATCH/PUT /status/1.json
  def update
    if @statu.update(status_params)
      render json: @statu
      # 'Status was successfully updated.'
    else
      render json: @statu.errors, status: :unprocessable_entity
    end
  end

  # DELETE /status/1
  # DELETE /status/1.json
  def destroy
    @status.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @statu = Statu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:statu).permit(:name, :code, :description, :user_id, :cargapp_model_id, :active)
    end
end
