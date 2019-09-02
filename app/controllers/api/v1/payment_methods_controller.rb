class Api::V1::PaymentMethodsController < ApplicationController
  before_action :set_payment_method, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user
  swagger_controller :payment_methods, 'Payment Methods'

  swagger_api :index do
    summary 'Fetches all Payment Method items'
    notes 'This lists all the payment methods'
  end

  swagger_api :active do
    summary 'Fetches all active Payment Method items'
    notes 'This lists all the active payment methods'
  end

  swagger_api :create do
    summary 'Creates a new Payment Method'
    param :form, 'payment_method[name]', :string, :required, 'Name'
    param :form, 'payment_method[uuid]', :string, :required, 'Uuid'
    param :form, 'payment_method[description]', :string, :required, 'Description'
    param :form, 'payment_method[email]', :string, :required, 'Email'
    param :form, 'payment_method[app_id]', :integer, :required, 'Id of app associated'
    param :form, 'payment_method[secret_id]', :integer, :required, 'Id of secret related to payment method'
    param :form, 'payment_method[token]', :string, :required, 'Token'
    param :form, 'payment_method[password]', :string, :required, 'Password'
    param :form, 'payment_method[user_id]', :integer, :required, 'Id of user associated to payment method'
    param :form, 'payment_method[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Parameter'
    param :path, :id, :integer, :required, "Payment method Id"
    param :form, 'payment_method[name]', :string, :optional, 'Name'
    param :form, 'payment_method[uuid]', :string, :optional, 'Uuid'
    param :form, 'payment_method[description]', :string, :optional, 'Description'
    param :form, 'payment_method[email]', :string, :optional, 'Email'
    param :form, 'payment_method[app_id]', :integer, :optional, 'Id of app associated'
    param :form, 'payment_method[secret_id]', :integer, :optional, 'Id of secret related to payment method'
    param :form, 'payment_method[token]', :string, :optional, 'Token'
    param :form, 'payment_method[password]', :string, :optional, 'Password'
    param :form, 'payment_method[user_id]', :integer, :optional, 'Id of user associated to payment method'
    param :form, 'payment_method[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Payment Method"
    param :path, :id, :integer, :optional, "Payment Method Id"
    response :unauthorized
    response :not_found
  end

  # GET /payment_methods
  # GET /payment_methods.json
  def index
    @payment_methods = PaymentMethod.all
    render json: @payment_methods
  end

  def active
    @payment_methods = PaymentMethod.where(active: true)
    render json: @payment_methods
  end

  # GET /payment_methods/1
  # GET /payment_methods/1.json
  def show
    render json: @payment_method
  end

  # POST /payment_methods
  # POST /payment_methods.json
  def create
    @payment_method = PaymentMethod.new(payment_method_params)
    if @payment_method.save
      render json: @payment_method, status: :created, location: @payment_method
    else
      render json: @payment_method.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payment_methods/1
  # PATCH/PUT /payment_methods/1.json
  def update
    if @payment_method.update(payment_method_params)
      render json: @payment_method, status: :ok, location: @payment_method
    else
      render json: @payment_method.errors, status: :unprocessable_entity
    end
  end

  # DELETE /payment_methods/1
  # DELETE /payment_methods/1.json
  def destroy
    @payment_method.destroy
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
    def set_payment_method
      @payment_method = PaymentMethod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_method_params
      params.require(:payment_method).permit(:name, :uuid, :description, :email, :aap_id, :secret_id, :token, :password, :user_id, :active)
    end
end
