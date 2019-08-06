class Api::V1::LoadTypesController < ApplicationController
  before_action :set_load_type, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary

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
