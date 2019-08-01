class Api::V1::ParametersController < ApplicationController
  before_action :set_parameter, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary

  # GET /parameters
  # GET /parameters.json
  def index
    @parameters = Parameter.all

    render json: @parameters
  end

  def active
    @parameters = Parameter.where(active: true)

    render json: @parameters
  end

  # GET /parameters/1
  # GET /parameters/1.json
  def show
    render json: @parameter
  end

  # POST /parameters
  # POST /parameters.json
  def create
    @parameter = Parameter.new(parameter_params)

    if @parameter.save
      render json: @parameter, status: :created, location: @parameter
      # 'Parameter was successfully created.'
    else
      render json: @parameter.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /parameters/1
  # PATCH/PUT /parameters/1.json
  def update
    if @parameter.update(parameter_params)
      render json: @parameter
      # 'Cargapp model was successfully updated.'
    else
      render json: @parameter.errors, status: :unprocessable_entity
    end
  end

  # DELETE /parameters/1
  # DELETE /parameters/1.json
  def destroy
    @parameter.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parameter
      @parameter = Parameter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parameter_params
      params.require(:parameter).permit(:name, :code, :description, :user_id, :value, :cargapp_model_id, :active)
    end
end
