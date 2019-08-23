class Api::V1::FavoriteRoutesController < ApplicationController
  before_action :set_favorite_route, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  # GET /favorite_routes
  # GET /favorite_routes.json
  def index
    @favorite_routes = FavoriteRoute.all
    render json: @favorite_routes
  end

  def active
    @favorite_routes = FavoriteRoute.where(active: true)
    render json: @favorite_routes
  end

  def me
    @favorite_routes = @user.favorite_routes
    render json: @favorite_routes
  end

  # GET /favorite_routes/1
  # GET /favorite_routes/1.json
  def show
    render json: @favorite_route
  end

  # POST /favorite_routes
  # POST /favorite_routes.json
  def create
    @favorite_route = FavoriteRoute.new(favorite_route_params)
    if @favorite_route.save
      render json: @favorite_route, status: :created, location: @favorite_route
    else
      render json: @favorite_route.errors, status: :unprocessable_entity
    end    
  end

  # PATCH/PUT /favorite_routes/1
  # PATCH/PUT /favorite_routes/1.json
  def update
    if @favorite_route.update(favorite_route_params)
      render json: @favorite_route, status: :ok, location: @favorite_route
    else
      render json: @favorite_route.errors, status: :unprocessable_entity
    end
  end

  # DELETE /favorite_routes/1
  # DELETE /favorite_routes/1.json
  def destroy
    @favorite_route.destroy
  end

  private
    def set_user
      @user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_favorite_route
      @favorite_route = FavoriteRoute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favorite_route_params
      params.require(:favorite_route).permit(:origin_city_id, :destination_city_id, :user_id, :active)
    end
end
