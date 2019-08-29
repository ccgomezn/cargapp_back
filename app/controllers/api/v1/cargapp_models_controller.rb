class Api::V1::CargappModelsController < ApplicationController
  before_action :set_cargapp_model, only: %i[show update destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  swagger_controller :cargappModels, 'Cargapp Models Management'

  swagger_api :index do
    summary 'Fetches all Cargapp Model items'
    notes 'This lists all the cargapp models'
  end

  swagger_api :active do
    summary 'Fetches all active Cargapp Model items'
    notes 'This lists all the active cargapp models'
  end

  swagger_api :create do
    summary 'Creates a new Cargapp Model'
    param :form, 'cargapp_model[name]', :string, :required, 'Name'
    param :form, 'cargapp_model[code]', :string, :required, 'Code'
    param :form, 'cargapp_model[description]', :string, :required, 'Description'
    param :form, 'cargapp_model[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Cargapp Model'
    param :path, :id, :integer, :required, "Cargapp Model Id"
    param :form, 'cargapp_model[name]', :string, :optional, 'Name'
    param :form, 'cargapp_model[code]', :string, :optional, 'Code'
    param :form, 'cargapp_model[description]', :string, :optional, 'Description'
    param :form, 'cargapp_model[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Cargapp Model"
    param :path, :id, :integer, :optional, "Cargapp Model Id"
    response :unauthorized
    response :not_found
  end

  # GET /cargapp_models
  # GET /cargapp_models.json
  def index
    @cargapp_models = CargappModel.all

    render json: @cargapp_models
  end

  def active
    @cargapp_models = CargappModel.where(active: true)

    render json: @cargapp_models
  end

  # GET /cargapp_models/1
  # GET /cargapp_models/1.json
  def show
    render json: @cargapp_model
  end

  # POST /cargapp_models
  # POST /cargapp_models.json
  def create
    @cargapp_model = CargappModel.new(cargapp_model_params)

    if @cargapp_model.save
      render json: @cargapp_model, status: :created, location: @cargapp_model
      # 'Cargapp model was successfully created.'
    else
      render json: @cargapp_model.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cargapp_models/1
  # PATCH/PUT /cargapp_models/1.json
  def update
    if @cargapp_model.update(cargapp_model_params)
      render json: @cargapp_model
      # 'Cargapp model was successfully updated.'
    else
      render json: @cargapp_model.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cargapp_models/1
  # DELETE /cargapp_models/1.json
  def destroy
    @cargapp_model.destroy
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
    def set_cargapp_model
      @cargapp_model = CargappModel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cargapp_model_params
      params.require(:cargapp_model).permit(:name, :code, :value, :description, :active)
    end
end
