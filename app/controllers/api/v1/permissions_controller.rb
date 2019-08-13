class Api::V1::PermissionsController < ApplicationController
  before_action :set_permission, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary

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
    # Use callbacks to share common setup or constraints between actions.
    def set_permission
      @permission = Permission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permission_params
      params.require(:permission).permit(:role_id, :cargapp_model_id, :action, :method, :allow, :user_id, :active)
    end

end
