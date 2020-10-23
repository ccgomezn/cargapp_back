class Api::V1::UserPaymentMethodsController < ApplicationController
  before_action :set_user_payment_method, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  swagger_controller :user_payment_methods, 'Payment methods of user'

  swagger_api :index do
    summary 'Fetches all User-Payment items'
    notes 'This lists all the user-payments'
  end

  swagger_api :active do
    summary 'Fetches all active User-Payment items'
    notes 'This lists all the active user-payments'
  end

  swagger_api :create do
    summary 'Creates a new User-Payment'
    param :form, 'user_payment_method[email]', :string, :required, 'Email'
    param :form, 'user_payment_method[uuid]', :string, :required, 'Uuid'
    param :form, 'user_payment_method[token]', :string, :required, 'Token'
    param :form, 'user_payment_method[card_number]', :string, :required, 'Card Number'
    param :form, 'user_payment_method[expiration]', :date, :required, 'Expiration date'
    param :form, 'user_payment_method[cvv]', :string, :required, 'Cvv'
    param :form, 'user_payment_method[observation]', :string, :required, 'Observation'
    param :form, 'user_payment_method[user_id]', :integer, :required, 'Id of user related'
    param :form, 'user_payment_method[payment_method_id]', :integer, :required, 'Id of payment method associated'
    param :form, 'user_payment_method[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing User-Payment'
    param :path, :id, :integer, :required, "Payment method Id"
    param :form, 'user_payment_method[email]', :string, :optional, 'Email'
    param :form, 'user_payment_method[uuid]', :string, :optional, 'Uuid'
    param :form, 'user_payment_method[token]', :string, :optional, 'Token'
    param :form, 'user_payment_method[card_number]', :string, :optional, 'Card Number'
    param :form, 'user_payment_method[expiration]', :date, :optional, 'Expiration date'
    param :form, 'user_payment_method[cvv]', :string, :optional, 'Cvv'
    param :form, 'user_payment_method[observation]', :string, :optional, 'Observation'
    param :form, 'user_payment_method[user_id]', :integer, :optional, 'Id of user related'
    param :form, 'user_payment_method[payment_method_id]', :integer, :optional, 'Id of payment method associated'
    param :form, 'user_payment_method[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing User-Payment Method"
    param :path, :id, :integer, :optional, "User-Payment Method Id"
    response :unauthorized
    response :not_found
  end

  swagger_api :show do
    summary "Shows an User-Payment Method"
    param :path, :id, :integer, :optional, "User-Payment Method Id"
    response :unauthorized
    response :not_found
  end

  swagger_api :mine do
    summary "Shows mine User-Payment Method"
    param :path, :id, :integer, :optional, "User-Payment Method Id"
    response :unauthorized
    response :not_found
  end
  # GET /user_payment_methods
  # GET /user_payment_methods.json
  def index
    @user_payment_methods = UserPaymentMethod.all

    render json: @user_payment_methods
  end

  def active
    @user_payment_methods = UserPaymentMethod.where(active: true)

    render json: @user_payment_methods
  end

  def me
    @user_payment_methods = @user.user_payment_methods

    render json: @user_payment_methods
  end

  # GET /user_payment_methods/1
  # GET /user_payment_methods/1.json
  def show
    render json: @user_payment_method
  end

  # POST /user_payment_methods
  # POST /user_payment_methods.json
  def create
    @user_payment_method = UserPaymentMethod.new(user_payment_method_params)
    if @user_payment_method.save
      render json: @user_payment_method, status: :created, location: @user_payment_method
    else
      render json: @user_payment_method.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_payment_methods/1
  # PATCH/PUT /user_payment_methods/1.json
  def update
    if @user_payment_method.update(user_payment_method_params)    
      render json: @user_payment_method, status: :ok, location: @user_payment_method
    else
      render json: @user_payment_method.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_payment_methods/1
  # DELETE /user_payment_methods/1.json
  def destroy
    @user_payment_method.destroy
    respond_to do |format|
      format.html { redirect_to user_payment_methods_url, notice: 'User payment method was successfully destroyed.' }
      format.json { head :no_content }
    end
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
        role = Role.find_by(name: 'USER', active: true)
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
    def set_user_payment_method
      @user_payment_method = UserPaymentMethod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_payment_method_params
      params.require(:user_payment_method).permit(:email, :uuid, :token, :card_number, :expiration, :cvv, :observation, :user_id, :payment_method_id, :active)
    end
end
