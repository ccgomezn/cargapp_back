class Api::V1::UserCouponsController < ApplicationController
  before_action :set_user_coupon, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

  # GET /user_coupons
  # GET /user_coupons.json
  def index
    @user_coupons = UserCoupon.all
    render json: @user_coupons
  end

  def active
    @user_coupons = UserCoupon.where(active: true)
    render json: @user_coupons
  end

  def me
    @user_coupons = @user.user_coupons
    render json: @user_coupons
  end

  # GET /user_coupons/1
  # GET /user_coupons/1.json
  def show
    render json: @user_coupon
  end

  # POST /user_coupons
  # POST /user_coupons.json
  def create
    @user_coupon = UserCoupon.new(user_coupon_params)
    if @user_coupon.save
      render json: @user_coupon, status: :created, location: @user_coupon
    else
      render json: @user_coupon.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_coupons/1
  # PATCH/PUT /user_coupons/1.json
  def update
    if @user_coupon.update(user_coupon_params)
      render json: @user_coupon, status: :ok, location: @user_coupon
    else
      render json: @user_coupon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_coupons/1
  # DELETE /user_coupons/1.json
  def destroy
    @user_coupon.destroy
  end

  private

    def set_user
      @user = User.all.first #User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user_coupon
      @user_coupon = UserCoupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_coupon_params
      params.require(:user_coupon).permit(:discount, :cargapp_model_id, :applied_item_id, :coupon_id, :user_id, :active)
    end
end
