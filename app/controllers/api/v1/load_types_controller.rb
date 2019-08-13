class Api::V1::LoadTypesController < ApplicationController
  before_action :set_load_type, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary

  swagger_controller :loadTypes, 'Load Types Management'

  swagger_api :index do
    summary 'Fetches all Load Types items'
    notes 'This lists all the load types'
  end

  swagger_api :active do
    summary 'Fetches all active Load Types items'
    notes 'This lists all the active load types'
  end

  swagger_api :create do
    summary 'Creates a new Load Type'
    param :form, :name, :string, :required, 'Name'
    param :form, :code, :string, :required, 'Code'
    param :form, :description, :string, :required, 'Description'
    param :form, :icon, :string, :required, 'Icon'
    param :form, :active, :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Load Type'
    param :path, :id, :integer, :required, "Load Type Id"
    param :form, :name, :string, :optional, 'Name'
    param :form, :code, :string, :optional, 'Code'
    param :form, :description, :string, :optional, 'Description'
    param :form, :icon, :string, :optional, 'Icon'
    param :form, :active, :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Load Type"
    param :path, :id, :integer, :optional, "Load Type Id"
    response :unauthorized
    response :not_found
  end




  # GET /load_types
  # GET /load_types.json
  def index
    @load_types = LoadType.all

    render json: @load_types
  end

  def active
    @load_types = LoadType.where(active: true)

    render json: @load_types
  end

  # GET /load_types/1
  # GET /load_types/1.json
  def show
    render json: @load_type
  end

  # POST /load_types
  # POST /load_types.json
  def create
    @load_type = LoadType.new(load_type_params)

    if @load_type.save
      render json: @load_type, status: :created, location: @load_type
      # 'load_type was successfully created.'
    else
      render json: @load_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /load_types/1
  # PATCH/PUT /load_types/1.json
  def update
    if @load_type.update(load_type_params)
      render json: @load_type
      # 'load_type was successfully updated.'
    else
      render json: @load_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /load_types/1
  # DELETE /load_types/1.json
  def destroy
    @load_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_load_type
      @load_type = LoadType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def load_type_params
      params.require(:load_type).permit(:name, :code, :icon, :description, :active)
    end
end
