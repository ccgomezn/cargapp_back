class Api::V1::PermissionsController < ApplicationController
  before_action :set_permission, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  swagger_controller :permissions, 'Permissions Management'

  swagger_api :index do
    summary 'Fetches all Permission items'
    notes 'This lists all the permissions'
  end

  swagger_api :active do
    summary 'Fetches all active Permission items'
    notes 'This lists all the active permissions'
  end

  swagger_api :create do
    summary 'Creates a new Permission'
    param :form, 'permission[role_id]', :integer, :required, 'Id of role related to permission'
    param :form, 'permission[model_id]', :integer, :required, 'Id of model related to permission'
    param :form, 'permission[action]', :string, :required, 'Action'
    param :form, 'permission[method]', :string, :required, 'Method'
    param :form, 'permission[user_id]', :integer, :required, 'Id of user related to permission'
    param :form, 'permission[allow]', :boolean, :required, 'Allow all actions'
    param :form, 'permission[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Permission'
    param :path, :id, :integer, :required, "Permission Id"
    param :form, 'permission[role_id]', :integer, :optional, 'Id of role related to permission'
    param :form, 'permission[model_id]', :integer, :optional, 'Id of model related to permission'
    param :form, 'permission[action]', :string, :optional, 'Action'
    param :form, 'permission[method]', :string, :optional, 'Method'
    param :form, 'permission[user_id]', :integer, :optional, 'Id of user related to permission'
    param :form, 'permission[allow]', :boolean, :optional, 'Allow all actions'
    param :form, 'permission[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Permission"
    param :path, :id, :integer, :optional, "Permission Id"
    response :unauthorized
    response :not_found
  end

  swagger_api :show do
    summary "Show Permission"
    param :path, :id, :integer, :optional, "Permission Id"
    response :unauthorized
    response :not_found
  end


  # GET /permissions
  # GET /permissions.json
  def index
    @permissions = Permission.all

    render json: @permissions
  end

  def active
    @permissions = Permission.where(active: true)

    render json: @permissions
  end

  # GET /permissions/1
  # GET /permissions/1.json
  def show
    render json: @permission
  end

  def me
    # Busco los roles del usuario
    roles = []
    @user.user_roles.each do |role|
      roles << role.role
    end

    # Busco los modelos de los roles
    models = []
    @user.user_roles.each do |role|
      role.role.permissions.each do |model|
        models << model.cargapp_model
      end
    end
    
    @obj = {
      user_role: @user.user_roles,
      roles: roles,
      models: CargappModel.where(id: models.uniq.pluck(:id) ) || models.uniq.pluck(:id)
    }

    render json: @obj, status: :ok
  end
  
  # POST /permissions
  # POST /permissions.json
  def create
    @permission = Permission.new(permission_params)

    if @permission.save
      render json: @permission, status: :created, location: @permission
      # 'Permission was successfully created.'
    else
      render json: @permission.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /permissions/1
  # PATCH/PUT /permissions/1.json
  def update
    if @permission.update(permission_params)
      render json: @permission
      # 'Permission was successfully updated.'
    else
      render json: @permission.errors, status: :unprocessable_entity
    end
  end

  # DELETE /permissions/1
  # DELETE /permissions/1.json
  def destroy
    @permission.destroy
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
        role = Role.find_by(name: 'USER', active: true)
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
    def set_permission
      @permission = Permission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permission_params
      params.require(:permission).permit(:role_id, :cargapp_model_id, :action, :method, :allow, :user_id, :active)
    end

end
