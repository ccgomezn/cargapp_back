class Api::V1::StatusController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary

  swagger_controller :status, 'Status Management'

  swagger_api :index do
    summary 'Fetches all Status items'
    notes 'This lists all the status'
  end

  swagger_api :active do
    summary 'Fetches all active Status items'
    notes 'This lists all the active status'
  end

  swagger_api :create do
    summary 'Creates a new Status'
    param :form, 'statu[name]', :string, :required, 'Name'
    param :form, 'statu[code]', :string, :required, 'Code'
    param :form, 'statu[description]', :string, :required, 'Description'
    param :form, 'statu[user_id]', :integer, :required, 'User id related to status'
    param :form, 'statu[cargapp_model_id]', :integer, :required, 'Model id related to status'
    param :form, 'statu[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Status'
    param :path, :id, :integer, :required, "Status Id"
    param :form, 'statu[name]', :string, :optional, 'Name'
    param :form, 'statu[code]', :string, :optional, 'Code'
    param :form, 'statu[description]', :string, :optional, 'Description'
    param :form, 'statu[user_id]', :integer, :optional, 'User id related to status'
    param :form, 'statu[cargapp_model_id]', :integer, :optional, 'Model id related to status'
    param :form, 'statu[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Status"
    param :path, :id, :integer, :optional, "Status Id"
    response :unauthorized
    response :not_found
  end

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
      # 'statu was successfully created.'
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
    @statu.destroy
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
