class Api::V1::CargappIntegrationsController < ApplicationController
  before_action :set_cargapp_integration, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

  swagger_controller :cargappIntegrantions, 'Cargapp Integrations Management'

  swagger_api :index do
    summary 'Fetches all Cargapp Intengrations items'
    notes 'This lists all the cargapp integrations'
  end

  swagger_api :active do
    summary 'Fetches all active Cargapp Integrations items'
    notes 'This lists all the active cargapp integrations'
  end

  swagger_api :create do
    summary 'Creates a new Cargapp Integration'
    param :form, :name, :string, :required, 'Name'
    param :form, :description, :string, :required, 'Description'
    param :form, :provider, :string, :required, 'Provider'
    param :form, :code, :string, :required, 'Code'
    param :form, :url, :string, :required, 'Url'
    param :form, :url_provider, :string, :required, 'Url of Provider'
    param :form, :url_production, :string, :required, 'Url for Production'
    param :form, :url_develop, :string, :required, 'Url for Develop'
    param :form, :email, :string, :required, 'Email'
    param :form, :username, :string, :required, 'Username'
    param :form, :password, :string, :required, 'Password'
    param :form, :phone, :string, :required, 'Phone'
    param :form, :pin, :string, :required, 'Pin'
    param :form, :token, :string, :required, 'Token'
    param :form, :app_id, :string, :required, 'Id of application'
    param :form, :client_id, :string, :required, 'Id of client'
    param :form, :api_key, :string, :required, 'Key of API'
    param :form, :user, :integer, :required, 'Id of user associated on integration'
    param :form, :active, :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Cargapp Integration'
    param :path, :id, :integer, :required, "Cargapp Integration Id"
    param :form, :name, :string, :optional, 'Name'
    param :form, :description, :string, :optional, 'Description'
    param :form, :provider, :string, :optional, 'Provider'
    param :form, :code, :string, :optional, 'Code'
    param :form, :url, :string, :optional, 'Url'
    param :form, :url_provider, :string, :optional, 'Url of Provider'
    param :form, :url_production, :string, :optional, 'Url for Production'
    param :form, :url_develop, :string, :optional, 'Url for Develop'
    param :form, :email, :string, :optional, 'Email'
    param :form, :username, :string, :optional, 'Username'
    param :form, :password, :string, :optional, 'Password'
    param :form, :phone, :string, :optional, 'Phone'
    param :form, :pin, :string, :optional, 'Pin'
    param :form, :token, :string, :optional, 'Token'
    param :form, :app_id, :string, :optional, 'Id of application'
    param :form, :client_id, :string, :optional, 'Id of client'
    param :form, :api_key, :string, :optional, 'Key of API'
    param :form, :user, :integer, :optional, 'Id of user associated on integration'
    param :form, :active, :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Cargapp Integration"
    param :path, :id, :integer, :optional, "Cargapp Integration Id"
    response :unauthorized
    response :not_found
  end


  # GET /cargapp_integrations
  # GET /cargapp_integrations.json
  def index
    @cargapp_integrations = CargappIntegration.all

    render json: @cargapp_integrations
  end

  def active
    @cargapp_integrations = CargappIntegration.where(active: true)

    render json: @cargapp_integrations
  end

  def me
    @cargapp_integrations = @user.cargapp_integrations #CargappIntegration.where(active: true, user_id: @user)

    render json: @cargapp_integrations
  end



  # GET /cargapp_integrations/1
  # GET /cargapp_integrations/1.json
  def show
    render json: @cargapp_integration
  end

  # POST /cargapp_integrations
  # POST /cargapp_integrations.json
  def create
    @cargapp_integration = CargappIntegration.new(cargapp_integration_params)

    if @cargapp_integration.save
      render json: @cargapp_integration, status: :created, location: @cargapp_integration
      # 'cargapp_integration was successfully created.'
    else
      render json: @cargapp_integration.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cargapp_integrations/1
  # PATCH/PUT /cargapp_integrations/1.json
  def update
    if @cargapp_integration.update(cargapp_integration_params)
      render json: @cargapp_integration
      # 'cargapp_integration was successfully updated.'
    else
      render json: @cargapp_integration.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cargapp_integrations/1
  # DELETE /cargapp_integrations/1.json
  def destroy
    @cargapp_integration.destroy
  end

  private

    def set_user
      @user = User.all.first #User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_cargapp_integration
      @cargapp_integration = CargappIntegration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cargapp_integration_params
      params.require(:cargapp_integration).permit(:name, :description, :provider, :code, :url, :url_provider, :url_production, :url_develop, :email, :username, :password, :phone, :pin, :token, :app_id, :client_id, :api_key, :user_id, :active)
    end
end
