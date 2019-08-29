class Api::V1::CargappIntegrationsController < ApplicationController
  before_action :set_cargapp_integration, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
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
    param :form, "cargapp_integration[name]", :string, :required, 'Name'
    param :form, "cargapp_integration[description]", :string, :required, 'Description'
    param :form, "cargapp_integration[provider]", :string, :required, 'Provider'
    param :form, "cargapp_integration[code]", :string, :required, 'Code'
    param :form, "cargapp_integration[url]", :string, :required, 'Url'
    param :form, "cargapp_integration[url_provider]", :string, :required, 'Url of Provider'
    param :form, "cargapp_integration[url_production]", :string, :required, 'Url for Production'
    param :form, "cargapp_integration[url_develop]", :string, :required, 'Url for Develop'
    param :form, "cargapp_integration[email]", :string, :required, 'Email'
    param :form, "cargapp_integration[username]", :string, :required, 'Username'
    param :form, "cargapp_integration[password]", :string, :required, 'Password'
    param :form, "cargapp_integration[phone]", :string, :required, 'Phone'
    param :form, "cargapp_integration[pin]", :string, :required, 'Pin'
    param :form, "cargapp_integration[token]", :string, :required, 'Token'
    param :form, "cargapp_integration[app_id]", :string, :required, 'Id of application'
    param :form, "cargapp_integration[client_id]", :string, :required, 'Id of client'
    param :form, "cargapp_integration[api_key]", :string, :required, 'Key of API'
    param :form, "cargapp_integration[user]", :integer, :required, 'Id of user associated on integration'
    param :form, "cargapp_integration[active]", :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Cargapp Integration'
    param :path, :id, :integer, :required, "Cargapp Integration Id"
    param :form, "cargapp_integration[name]", :string, :optional, 'Name'
    param :form, "cargapp_integration[description]", :string, :optional, 'Description'
    param :form, "cargapp_integration[provider]", :string, :optional, 'Provider'
    param :form, "cargapp_integration[code]", :string, :optional, 'Code'
    param :form, "cargapp_integration[url]", :string, :optional, 'Url'
    param :form, "cargapp_integration[url_provider]", :string, :optional, 'Url of Provider'
    param :form, "cargapp_integration[url_production]", :string, :optional, 'Url for Production'
    param :form, "cargapp_integration[url_develop]", :string, :optional, 'Url for Develop'
    param :form, "cargapp_integration[email]", :string, :optional, 'Email'
    param :form, "cargapp_integration[username]", :string, :optional, 'Username'
    param :form, "cargapp_integration[password]", :string, :optional, 'Password'
    param :form, "cargapp_integration[phone]", :string, :optional, 'Phone'
    param :form, "cargapp_integration[pin]", :string, :optional, 'Pin'
    param :form, "cargapp_integration[token]", :string, :optional, 'Token'
    param :form, "cargapp_integration[app_id]", :string, :optional, 'Id of application'
    param :form, "cargapp_integration[client_id]", :string, :optional, 'Id of client'
    param :form, "cargapp_integration[api_key]", :string, :optional, 'Key of API'
    param :form, "cargapp_integration[user]", :integer, :optional, 'Id of user associated on integration'
    param :form, "cargapp_integration[active]", :boolean, :optional, 'State of activation'
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
      @user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      permissions()
    end
  
    def permissions
      if @user
        has_permission = false
        @user.roles.where(active: true).each do |role|
          next if role.permissions.where(active: true).empty?
          role.permissions.where(active: true).each do |permission|
            if (permission.cargapp_model.value.eql?(controller_name) && permission.active) && permission.action.eql?('all')
              has_permission = true
            elsif (permission.cargapp_model.value.eql?(controller_name) && permission.active) && permission.allow
              has_permission = true
            elsif (permission.cargapp_model.value.eql?(controller_name) && permission.active) && permission.action.eql?(action_name)
              has_permission = true
            end
          end
        end
  
        if if_super()
          has_permission = true
        end
  
        if has_permission
          true
        else
          response = { response: "Does not have permissions" }
          render json: response, status: :unprocessable_entity
        end
      else
        role = Role.find_by(name: ENV['GUEST_N'], active: true)
        has_permission = false
        role.permissions.each do |permission|
          if (permission.cargapp_model.value.eql?(controller_name) && permission.active) && permission.action.eql?('all')
            has_permission = true
          elsif (permission.cargapp_model.value.eql?(controller_name) && permission.active) && permission.allow
            has_permission = true
          elsif (permission.cargapp_model.value.eql?(controller_name) && permission.active) && permission.action.eql?(action_name)
            has_permission = true
          end
        end
  
        if has_permission
          true
        else
          response = { response: "Does not have permissions" }
          render json: response, status: :unprocessable_entity
        end
      end
    end
  
    def if_super
      @if_super = (User.is_super?(@user) if @user) || false
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
