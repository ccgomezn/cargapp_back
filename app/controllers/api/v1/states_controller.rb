class Api::V1::StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  swagger_controller :states, 'States Location Management'

  swagger_api :index do
    summary 'Fetches all States items'
    notes 'This lists all the states'
  end

  swagger_api :active do
    summary 'Fetches all active States items'
    notes 'This lists all the active states'
  end

  swagger_api :create do
    summary 'Creates a new States'
    param :form, 'state[name]', :string, :required, 'Name'
    param :form, 'state[code]', :string, :required, 'Code'
    param :form, 'state[description]', :string, :required, 'Description'
    param :form, 'state[country_id]', :integer, :required, 'Country id related to status'
    param :form, 'state[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing State'
    param :path, :id, :integer, :required, "State Id"
    param :form, 'state[name]', :string, :optional, 'Name'
    param :form, 'state[code]', :string, :optional, 'Code'
    param :form, 'state[description]', :string, :optional, 'Description'
    param :form, 'state[country_id]', :integer, :optional, 'Country id related to status'
    param :form, 'state[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing State"
    param :path, :id, :integer, :optional, "State Id"
    response :unauthorized
    response :not_found
  end

  # GET /states
  # GET /states.json
  def index
    @states = State.all
        
    render json: @states
  end

  def active
    @states = State.where(active: true)

    render json: @states
  end

  # GET /states/1
  # GET /states/1.json
  def show
    render json: @state
  end

  # POST /states
  # POST /states.json
  def create
    @state = State.new(state_params)

    if @state.save
      render json: @state, status: :created, location: @state
      # 'state was successfully created.'
    else
      render json: @state.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /states/1
  # PATCH/PUT /states/1.json
  def update
    if @state.update(state_params)
      render json: @state
      # 'State was successfully updated.'
    else
      render json: @state.errors, status: :unprocessable_entity
    end
  end

  # DELETE /states/1
  # DELETE /states/1.json
  def destroy
    @state.destroy
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
    def set_state
      @state = State.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def state_params
      params.require(:state).permit(:name, :code, :description, :country_id, :active)
    end
end
