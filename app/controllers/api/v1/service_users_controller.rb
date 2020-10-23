class Api::V1::ServiceUsersController < ApplicationController
  before_action :set_service_user, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  # GET /service_users
  # GET /service_users.json
  def index
    @service_users = ServiceUser.all
    render json: @service_users
  end

  def active
    @service_users = ServiceUser.where(active: true)
    render json: @service_users
  end

  def me
    @service_users = @user.service_users
    render json: @service_users
  end

  def approved
    @service_users = ServiceUser.where(approved: true)
    render json: @service_users
  end

  def find_service
    @service_user = ServiceUser.where(service_id: params[:id])
    users = []
    @service_user.each do |user|
      user_obj = {
        service_user: user,
        user: user.user
        #profile: user.user.profile
      }
      users << user_obj || user.user
    end
    render json: users
  end

  # GET /service_users/1
  # GET /service_users/1.json
  def show
    render json: @service_user
  end

  # POST /service_users
  # POST /service_users.json
  def create
    @service_user = ServiceUser.new(service_user_params)
      if @service_user.save
        render json: @service_user, status: :created, location: @service_user
      else
        render json: @service_user.errors, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /service_users/1
  # PATCH/PUT /service_users/1.json
  def update    
    if @service_user.update(service_user_params)      
      render json: @service_user, status: :ok, location: @service_user
    else
      render json: @service_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /service_users/1
  # DELETE /service_users/1.json
  def destroy
    @service_user.destroy    
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
    def set_service_user
      @service_user = ServiceUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_user_params
      params.require(:service_user).permit(:service_id, :user_id, :position, :approved, :expiration_date, :active, :vehicle_id)
    end
end
