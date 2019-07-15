class PermissionsController < ApplicationController
  before_action :set_permission, only: [:show, :edit, :update, :destroy]
  before_action :models

  # GET /permissions
  # GET /permissions.json
  def index
    @permissions = Permission.all
  end

  # GET /permissions/1
  # GET /permissions/1.json
  def show
  end

  # GET /permissions/new
  def new
    @permission = Permission.new
  end

  # GET /permissions/1/edit
  def edit
  end

  # POST /permissions
  # POST /permissions.json
  def create
    @permission = Permission.new(permission_params)

    respond_to do |format|
      if @permission.save
        format.html { redirect_to @permission, notice: 'Permission was successfully created.' }
        format.json { render :show, status: :created, location: @permission }
      else
        format.html { render :new }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permissions/1
  # PATCH/PUT /permissions/1.json
  def update
    respond_to do |format|
      if @permission.update(permission_params)
        format.html { redirect_to @permission, notice: 'Permission was successfully updated.' }
        format.json { render :show, status: :ok, location: @permission }
      else
        format.html { render :edit }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions/1
  # DELETE /permissions/1.json
  def destroy
    @permission.destroy
    respond_to do |format|
      format.html { redirect_to permissions_url, notice: 'Permission was successfully destroyed.' }
      format.json { head :no_content }
    end
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

    def models
      @users = User.all
      @roles = Role.all
      @cargapp_models = CargappModel.all
      cargapp_actions = Parameter.find_by(code: ENV['PARAMETER_ACTION'])
      @cargapp_action = []
      cargapp_actions.value.split(',') do |cargapp_action|
        # obj = { "name" =>  cargapp_action, "code" => cargapp_action.upcase }
        # @cargapp_action << obj
        @cargapp_action << cargapp_action
      end

      cargapp_methods = Parameter.find_by(code: ENV['PARAMETER_METHODS'])
      @cargapp_method = []
      cargapp_methods.value.split(',') do |cargapp_method|
        @cargapp_method << cargapp_method
      end
    end
end
