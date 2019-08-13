class Api::V1::CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = Coupon.all
    render json: @coupons
  end

  def active
    @coupons = Coupon.where(active: true)
    render json: @coupons
  end

  def me
    @coupons = @user.coupons
    render json: @coupons
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
    render json: @coupon
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = Coupon.new(coupon_params)
    if @coupon.save
      render json: @coupon, status: :created, location: @coupon
    else
      render json: @coupon.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    if @coupon.update(coupon_params)
      render json: @coupon, status: :ok, location: @coupon
    else
      render json: @coupon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon.destroy
  end

  private

    def set_user
      @user = User.all.first #User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:name, :code, :description, :is_porcentage, :value, :quantity, :cargapp_model_id, :user_id, :active)
    end
end
