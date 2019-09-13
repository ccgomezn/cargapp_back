class Api::V1::UserLocationsController < ApplicationController
  before_action :set_user_location, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user



  swagger_controller :userLocation, 'User Locations Management'

  swagger_api :index do
    summary 'Fetches all user Location items'
    notes 'This lists all the user locations'
  end

  swagger_api :active do
    summary 'Fetches all active User Location items'
    notes 'This lists all the active user locations'
  end

  swagger_api :create do
    summary 'Creates a new Service Location'
    param :form, 'user_location[longitude]', :string, :required, 'Longitude'
    param :form, 'user_location[latitude]', :string, :required, 'Latitude'
    param :form, 'user_location[city_id]', :file, :required, 'Id of city related'
    param :form, 'user_location[user_id]', :integer, :required, 'Id of user related'
    param :form, 'user_location[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing User Location'
    param :path, :id, :integer, :required, "User Location Id"
    param :form, 'user_location[longitude]', :string, :optional, 'Longitude'
    param :form, 'user_location[latitude]', :string, :optional, 'Latitude'
    param :form, 'user_location[city_id]', :file, :optional, 'Id of city related'
    param :form, 'user_location[user_id]', :integer, :optional, 'Id of user related'
    param :form, 'user_location[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing User Location"
    param :path, :id, :integer, :optional, "User Location Id"
    response :unauthorized
    response :not_found
  end

  # GET /user_locations
  # GET /user_locations.json
  def index
    @user_locations = UserLocation.all
    render json: @user_locations
  end

  def active
    @user_locations = UserLocation.where(active: true)
    render json: @user_locations
  end

  def me
    @user_locations = @user.user_locations
    render json: @user_locations
  end

  # GET /user_locations/1
  # GET /user_locations/1.json
  def show
    render json: @user_location
  end

  # POST /user_locations
  # POST /user_locations.json
  def create
    @user_location = UserLocation.new(user_location_params)
    if @user_location.save
      render json: @user_location, status: :created, location: @user_location
    else    
      render json: @user_location.errors, status: :unprocessable_entity
    end    
  end

  # PATCH/PUT /user_locations/1
  # PATCH/PUT /user_locations/1.json
  def update
    if @user_location.update(user_location_params)
      render json: @user_location, status: :ok, location: @user_location
    else
      render json: @user_location.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_locations/1
  # DELETE /user_locations/1.json
  def destroy
    @user_location.destroy
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
    def set_user_location
      @user_location = UserLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_location_params
      params.require(:user_location).permit(:longitude, :latitude, :city_id, :user_id, :active)
    end
end
