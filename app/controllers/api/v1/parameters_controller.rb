class Api::V1::ParametersController < ApplicationController
  before_action :set_parameter, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  swagger_controller :parameters, 'Parameters Management'

  swagger_api :index do
    summary 'Fetches all Parameters items'
    notes 'This lists all the parameters'
  end

  swagger_api :active do
    summary 'Fetches all active Parameters items'
    notes 'This lists all the active parameters'
  end

  swagger_api :show do
    summary 'Fetches detailed Parameters items'
    param :path, :id, :integer, :optional, "Parameter Id"
    notes 'This lists detailed active parameters'
  end

  swagger_api :create do
    summary 'Creates a new Parameter'
    param :form, 'parameter[name]', :string, :required, 'Name'
    param :form, 'parameter[code]', :string, :required, 'Code'
    param :form, 'parameter[description]', :string, :required, 'Description'
    param :form, 'parameter[user_id]', :integer, :required, 'Id of user related to parameter'
    param :form, 'parameter[value]', :string, :required, 'Value'
    param :form, 'parameter[model_id]', :integer, :required, 'Id of model related to parameter'
    param :form, 'parameter[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Parameter'
    param :path, :id, :integer, :required, "Parameter Id"
    param :form, 'parameter[name]', :string, :optional, 'Name'
    param :form, 'parameter[code]', :string, :optional, 'Code'
    param :form, 'parameter[description]', :string, :optional, 'Description'
    param :form, 'parameter[user_id]', :integer, :optional, 'Id of user related to parameter'
    param :form, 'parameter[value]', :string, :optional, 'Value'
    param :form, 'parameter[model_id]', :integer, :optional, 'Id of model related to parameter'
    param :form, 'parameter[active]', :boolean, :optional, 'State of activation'
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
  swagger_api :find do
    summary "Fetches parameters by code"
    param :path, :id, :integer, :optional, "Parameter Code"
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

  def find
    puts 'ddddd'
    puts params['code']
    @parameter = Parameter.find_by(code: params['code'])

    @result = []

    if @parameter.value.include?('|')
      @parameter.value.split('|').each do |parameter|
        obj = {
          name: parameter,
          code: parameter
        }
        @result << obj
      end
    else
      @parameter.value.split(',').each do |parameter|
        obj = {
          name: parameter,
          code: parameter
        }
        @result << obj
      end
    end

    @obj = {
      parameter: @parameter,
      parameters: @result
    }
    render json: @obj
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
    def set_parameter
      @parameter = Parameter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parameter_params
      params.require(:parameter).permit(:name, :code, :description, :user_id, :value, :cargapp_model_id, :active)
    end
end
