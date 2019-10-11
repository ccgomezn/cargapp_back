class ServiceUsersController < ApplicationController
  before_action :set_service_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /service_users
  # GET /service_users.json
  def index
    @service_users = ServiceUser.all
  end

  # GET /service_users/1
  # GET /service_users/1.json
  def show
  end

  # GET /service_users/new
  def new
    @service_user = ServiceUser.new
  end

  # GET /service_users/1/edit
  def edit
  end

  # POST /service_users
  # POST /service_users.json
  def create
    @service_user = ServiceUser.new(service_user_params)

    respond_to do |format|
      if @service_user.save
        format.html { redirect_to @service_user, notice: 'Service user was successfully created.' }
        format.json { render :show, status: :created, location: @service_user }
      else
        format.html { render :new }
        format.json { render json: @service_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /service_users/1
  # PATCH/PUT /service_users/1.json
  def update
    respond_to do |format|
      if @service_user.update(service_user_params)
        format.html { redirect_to @service_user, notice: 'Service user was successfully updated.' }
        format.json { render :show, status: :ok, location: @service_user }
      else
        format.html { render :edit }
        format.json { render json: @service_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_users/1
  # DELETE /service_users/1.json
  def destroy
    @service_user.destroy
    respond_to do |format|
      format.html { redirect_to service_users_url, notice: 'Service user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_user
      @service_user = ServiceUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_user_params
      params.require(:service_user).permit(:service_id, :user_id, :position, :approved, :expiration_date, :active)
    end
end
