class Api::V1::PermissionsController < ApplicationController
  before_action :set_permission, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary

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
