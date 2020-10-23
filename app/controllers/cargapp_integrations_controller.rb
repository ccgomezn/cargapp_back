class CargappIntegrationsController < ApplicationController
  before_action :set_cargapp_integration, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /cargapp_integrations
  # GET /cargapp_integrations.json
  def index
    @cargapp_integrations = CargappIntegration.all
  end

  # GET /cargapp_integrations/1
  # GET /cargapp_integrations/1.json
  def show
  end

  # GET /cargapp_integrations/new
  def new
    @cargapp_integration = CargappIntegration.new
  end

  # GET /cargapp_integrations/1/edit
  def edit
  end

  # POST /cargapp_integrations
  # POST /cargapp_integrations.json
  def create
    @cargapp_integration = CargappIntegration.new(cargapp_integration_params)

    respond_to do |format|
      if @cargapp_integration.save
        format.html { redirect_to @cargapp_integration, notice: 'Cargapp integration was successfully created.' }
        format.json { render :show, status: :created, location: @cargapp_integration }
      else
        format.html { render :new }
        format.json { render json: @cargapp_integration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cargapp_integrations/1
  # PATCH/PUT /cargapp_integrations/1.json
  def update
    respond_to do |format|
      if @cargapp_integration.update(cargapp_integration_params)
        format.html { redirect_to @cargapp_integration, notice: 'Cargapp integration was successfully updated.' }
        format.json { render :show, status: :ok, location: @cargapp_integration }
      else
        format.html { render :edit }
        format.json { render json: @cargapp_integration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cargapp_integrations/1
  # DELETE /cargapp_integrations/1.json
  def destroy
    @cargapp_integration.destroy
    respond_to do |format|
      format.html { redirect_to cargapp_integrations_url, notice: 'Cargapp integration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cargapp_integration
    @cargapp_integration = CargappIntegration.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cargapp_integration_params
    params.require(:cargapp_integration).permit(:name, :description, :provider, :code, :url, :url_provider, :url_production, :url_develop, :email, :username, :password, :phone, :pin, :token, :app_id, :client_id, :api_key, :user_id, :active)
  end
end
