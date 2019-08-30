class Api::V1::CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user


  swagger_controller :coupons, 'Coupons Management'

  swagger_api :index do
    summary 'Fetches all Coupons items'
    notes 'This lists all the coupons'
  end

  swagger_api :active do
    summary 'Fetches all active Coupons items'
    notes 'This lists all the active coupons'
  end

  swagger_api :create do
    summary 'Creates a new Coupon'
    param :form, 'coupon[name]', :string, :required, 'Name'
    param :form, 'coupon[code]', :string, :required, 'Code'
    param :form, 'coupon[description]', :string, :required, 'Description'
    param :form, 'coupon[cargapp_model_id]', :integer, :required, 'Id of cargapp model associated on coupon'
    param :form, 'coupon[is_porcentage]', :boolean, :required, 'Check if the value is percentage'
    param :form, 'coupon[value]', :integer, :required, 'Value'
    param :form, 'coupon[quantity]', :integer, :required, 'Quantity'
    param :form, 'coupon[user_id]', :integer, :required, 'Id user on coupon'
    param :form, 'coupon[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Coupon'
    param :path, :id, :integer, :required, "Coupon Id"
    param :form, 'coupon[name]', :string, :optional, 'Name'
    param :form, 'coupon[code]', :string, :optional, 'Code'
    param :form, 'coupon[description]', :string, :optional, 'Description'
    param :form, 'coupon[cargapp_model_id]', :integer, :optional, 'Id of cargapp model associated on coupon'
    param :form, 'coupon[is_porcentage]', :boolean, :optional, 'Check if the value is percentage'
    param :form, 'coupon[value]', :integer, :optional, 'Value'
    param :form, 'coupon[quantity]', :integer, :optional, 'Quantity'
    param :form, 'coupon[user_id]', :integer, :optional, 'Id user on coupon'
    param :form, 'coupon[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Coupon"
    param :path, :id, :integer, :optional, "Coupon Id"
    response :unauthorized
    response :not_found
  end

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
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:name, :code, :description, :is_porcentage, :value, :quantity, :cargapp_model_id, :user_id, :active)
    end
end
