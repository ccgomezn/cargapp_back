class Api::V1::RateServicesController < ApplicationController
  before_action :set_rate_service, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  # GET /rate_services
  # GET /rate_services.json
  def index
    @rate_services = RateService.all
    render json: @rate_services
  end

  def active
    @rate_services = RateService.where(active: true)
    render json: @rate_services
  end

  def me
    @rate_services = @user.rate_services
    render json: @rate_services
  end

  # GET /rate_services/1
  # GET /rate_services/1.json
  def show
    render json: @rate_service
  end

  # POST /rate_services
  # POST /rate_services.json
  def create
    @rate_service = RateService.new(rate_service_params)
    if @rate_service.save
      render json: @rate_service, status: :created, location: @rate_service
    else    
      render json: @rate_service.errors, status: :unprocessable_entity
    end    
  end

  # PATCH/PUT /rate_services/1
  # PATCH/PUT /rate_services/1.json
  def update
    if @rate_service.update(rate_service_params)
      render json: @rate_service, status: :ok, location: @rate_service
    else
      render json: @rate_service.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rate_services/1
  # DELETE /rate_services/1.json
  def destroy
    @rate_service.destroy
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
    def set_rate_service
      @rate_service = RateService.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rate_service_params
      params.require(:rate_service).permit(:service_point, :driver_point, :point, :service_id, :user_id, :driver_id, :active)
    end
end
