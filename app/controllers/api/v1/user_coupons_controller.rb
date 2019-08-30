class Api::V1::UserCouponsController < ApplicationController
  before_action :set_user_coupon, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  swagger_controller :userCoupons, 'User-Coupon Relation Management'

  swagger_api :index do
    summary 'Fetches all User-Coupon items'
    notes 'This lists all the User-Coupons'
  end

  swagger_api :active do
    summary 'Fetches all active User-Coupon items'
    notes 'This lists all the active User-Coupons'
  end

  swagger_api :create do
    summary 'Creates a new User-Coupon'
    param :form, 'user_coupon[applied_item_id]', :integer, :required, 'Id of item on offer'
    param :form, 'user_coupon[cargapp_model_id]', :integer, :required, 'Id of model associated'
    param :form, 'user_coupon[coupon_id]', :integer, :required, 'Id of coupon associated'
    param :form, 'user_coupon[user_id]', :integer, :required, 'Id of user associated'
    param :form, 'user_coupon[offer_id]', :integer, :required, 'Id of offer associated'
    param :form, 'user_coupon[discount]', :integer, :required, 'Discount'
    param :form, 'user_coupon[active]', :boolean, :required, 'Activation state'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing User-Coupon'
    param :path, :id, :integer, :required, "User-Coupon Id"
    param :form, 'user_coupon[applied_item_id]', :integer, :optional, 'Id of item on offer'
    param :form, 'user_coupon[cargapp_model_id]', :integer, :optional, 'Id of model associated'
    param :form, 'user_coupon[coupon_id]', :integer, :optional, 'Id of coupon associated'
    param :form, 'user_coupon[user_id]', :integer, :optional, 'Id of user associated'
    param :form, 'user_coupon[offer_id]', :integer, :optional, 'Id of offer associated'
    param :form, 'user_coupon[discount]', :integer, :optional, 'Discount'
    param :form, 'user_coupon[active]', :boolean, :optional, 'Activation state'
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing User-Coupon"
    param :path, :id, :integer, :optional, "User-Coupon Id"
    response :unauthorized
    response :not_found
  end

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
    def set_user_coupon
      @user_coupon = UserCoupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_coupon_params
      params.require(:user_coupon).permit(:discount, :cargapp_model_id, :applied_item_id, :coupon_id, :user_id, :active)
    end
end
