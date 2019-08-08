class Api::V1::ParametersController < ApplicationController
  before_action :set_parameter, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary

  swagger_controller :parameters, 'Parameters Management'

  swagger_api :index do
    summary 'Fetches all Parameters items'
    notes 'This lists all the parameters'
  end

  swagger_api :active do
    summary 'Fetches all active Parameters items'
    notes 'This lists all the active parameters'
  end

  swagger_api :create do
    summary 'Creates a new Parameter'
    param :form, :name, :string, :required, 'Name'
    param :form, :code, :string, :required, 'Code'
    param :form, :description, :string, :required, 'Description'
    param :form, :user_id, :integer, :required, 'Id of user related to parameter'
    param :form, :value, :string, :required, 'Value'
    param :form, :model_id, :integer, :required, 'Id of model related to parameter'
    param :form, :active, :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Parameter'
    param :path, :id, :integer, :required, "Parameter Id"
    param :form, :name, :string, :optional, 'Name'
    param :form, :code, :string, :optional, 'Code'
    param :form, :description, :string, :optional, 'Description'
    param :form, :user_id, :integer, :optional, 'Id of user related to parameter'
    param :form, :value, :string, :optional, 'Value'
    param :form, :model_id, :integer, :optional, 'Id of model related to parameter'
    param :form, :active, :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Parameter"
    param :path, :id, :integer, :optional, "Parameter Id"
    response :unauthorized
    response :not_found
  end

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
