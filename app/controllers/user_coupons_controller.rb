class UserCouponsController < ApplicationController
  before_action :set_user_coupon, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /user_coupons
  # GET /user_coupons.json
  def index
    @user_coupons = UserCoupon.all
  end

  # GET /user_coupons/1
  # GET /user_coupons/1.json
  def show
  end

  # GET /user_coupons/new
  def new
    @user_coupon = UserCoupon.new
  end

  # GET /user_coupons/1/edit
  def edit
  end

  # POST /user_coupons
  # POST /user_coupons.json
  def create
    @user_coupon = UserCoupon.new(user_coupon_params)

    respond_to do |format|
      if @user_coupon.save
        format.html { redirect_to @user_coupon, notice: 'User coupon was successfully created.' }
        format.json { render :show, status: :created, location: @user_coupon }
      else
        format.html { render :new }
        format.json { render json: @user_coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_coupons/1
  # PATCH/PUT /user_coupons/1.json
  def update
    respond_to do |format|
      if @user_coupon.update(user_coupon_params)
        format.html { redirect_to @user_coupon, notice: 'User coupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_coupon }
      else
        format.html { render :edit }
        format.json { render json: @user_coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_coupons/1
  # DELETE /user_coupons/1.json
  def destroy
    @user_coupon.destroy
    respond_to do |format|
      format.html { redirect_to user_coupons_url, notice: 'User coupon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_coupon
      @user_coupon = UserCoupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_coupon_params
      params.require(:user_coupon).permit(:discount, :cargapp_model_id, :applied_item_id, :coupon_id, :user_id, :active)
    end
end
