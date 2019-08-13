class Api::V1::CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  swagger_controller :cities, 'Cities Management'

  swagger_api :index do
    summary 'Fetches all City items'
    notes 'This lists all the cities'
  end

  swagger_api :active do
    summary 'Fetches all active City items'
    notes 'This lists all the active cities'
  end

  swagger_api :create do
    summary 'Creates a new City'
    param :form, 'city[name]', :string, :required, 'Name'
    param :form, 'city[code]', :string, :required, 'Code'
    param :form, 'city[description]', :string, :required, 'Description'
    param :form, 'city[state_id]', :integer, :required, 'State Id related to City'
    param :form, 'city[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing City'
    param :path, :id, :integer, :required, "City Id"
     param :form, 'city[name]', :string, :optional, 'Name'
    param :form, 'city[code]', :string, :optional, 'Code'
    param :form, 'city[description]', :string, :optional, 'Description'
    param :form, 'city[state_id]', :integer, :optional, 'State Id related to City'
    param :form, 'city[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing City"
    param :path, :id, :integer, :optional, "City Id"
    response :unauthorized
    response :not_found
  end

  # GET /cities
  # GET /cities.json
  def index
    @cities = City.all

    render json: @cities
  end

  def active
    @cities = City.where(active: true)

    render json: @cities
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
    render json: @city
  end
  
  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(city_params)

    if @city.save
      render json: @city, status: :created, location: @city
      # 'city model was successfully created.'
    else
      render json: @city.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    if @city.update(city_params)
      render json: @city
      # 'city was successfully updated.'
    else
      render json: @city.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name, :code, :description, :state_id, :active)
    end
end
