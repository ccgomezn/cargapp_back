class Api::V1::CargappIntegrationsController < ApplicationController
  before_action :set_cargapp_integration, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

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
