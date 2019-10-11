class FavoriteRoutesController < ApplicationController
  before_action :set_favorite_route, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /favorite_routes
  # GET /favorite_routes.json
  def index
    @favorite_routes = FavoriteRoute.all
  end

  # GET /favorite_routes/1
  # GET /favorite_routes/1.json
  def show
  end

  # GET /favorite_routes/new
  def new
    @favorite_route = FavoriteRoute.new
  end

  # GET /favorite_routes/1/edit
  def edit
  end

  # POST /favorite_routes
  # POST /favorite_routes.json
  def create
    @favorite_route = FavoriteRoute.new(favorite_route_params)

    respond_to do |format|
      if @favorite_route.save
        format.html { redirect_to @favorite_route, notice: 'Favorite route was successfully created.' }
        format.json { render :show, status: :created, location: @favorite_route }
      else
        format.html { render :new }
        format.json { render json: @favorite_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favorite_routes/1
  # PATCH/PUT /favorite_routes/1.json
  def update
    respond_to do |format|
      if @favorite_route.update(favorite_route_params)
        format.html { redirect_to @favorite_route, notice: 'Favorite route was successfully updated.' }
        format.json { render :show, status: :ok, location: @favorite_route }
      else
        format.html { render :edit }
        format.json { render json: @favorite_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorite_routes/1
  # DELETE /favorite_routes/1.json
  def destroy
    @favorite_route.destroy
    respond_to do |format|
      format.html { redirect_to favorite_routes_url, notice: 'Favorite route was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite_route
      @favorite_route = FavoriteRoute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favorite_route_params
      params.require(:favorite_route).permit(:origin_city_id, :destination_city_id, :user_id, :active)
    end
end
