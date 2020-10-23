class Api::V1::PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  swagger_controller :payments, 'Payments'

  swagger_api :index do
    summary 'Fetches all Payment items'
    notes 'This lists all the payment methods'
  end

  swagger_api :active do
    summary 'Fetches all active Payment items'
    notes 'This lists all the active payment'
  end

  swagger_api :create do
    summary 'Creates a new Payment'
    param :form, 'payment[uuid]', :string, :required, 'Uuid'
    param :form, 'payment[total]', :string, :required, 'Total'
    param :form, 'payment[sub_total]', :string, :required, 'Sub total'
    param :form, 'payment[taxes]', :string, :required, 'Taxes'
    param :form, 'payment[transaction_code]', :integer, :required, 'Transaction code'
    param :form, 'payment[observation]', :integer, :required, 'Observation'
    param :form, 'payment[coupon_id]', :string, :required, 'Id of coupon'
    param :form, 'payment[coupon_code]', :string, :required, 'Coupon code'
    param :form, 'payment[coupon_amount]', :integer, :required, 'Coupon amount'
    param :form, 'payment[user_payment_method_id]', :integer, :required, 'Id of user payment method'
    param :form, 'payment[payment_method_id]', :integer, :required, 'Id of payment method'
    param :form, 'payment[statu_id]', :integer, :required, 'Id of status'
    param :form, 'payment[user_id]', :integer, :required, 'Id of user'
    param :form, 'payment[is_service]', :boolean, :required, 'Checked if is service'
    param :form, 'payment[service_id]', :integer, :required, 'Id of service related'
    param :form, 'payment[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Parameter'
    param :path, :id, :integer, :required, "Payment method Id"
    param :form, 'payment[uuid]', :string, :optional, 'Uuid'
    param :form, 'payment[total]', :string, :optional, 'Total'
    param :form, 'payment[sub_total]', :string, :optional, 'Sub total'
    param :form, 'payment[taxes]', :string, :optional, 'Taxes'
    param :form, 'payment[transaction_code]', :integer, :optional, 'Transaction code'
    param :form, 'payment[observation]', :integer, :optional, 'Observation'
    param :form, 'payment[coupon_id]', :string, :optional, 'Id of coupon'
    param :form, 'payment[coupon_code]', :string, :optional, 'Coupon code'
    param :form, 'payment[coupon_amount]', :integer, :optional, 'Coupon amount'
    param :form, 'payment[user_payment_method_id]', :integer, :optional, 'Id of user payment method'
    param :form, 'payment[payment_method_id]', :integer, :optional, 'Id of payment method'
    param :form, 'payment[statu_id]', :integer, :optional, 'Id of status'
    param :form, 'payment[user_id]', :integer, :optional, 'Id of user'
    param :form, 'payment[is_service]', :boolean, :optional, 'Checked if is service'
    param :form, 'payment[service_id]', :integer, :optional, 'Id of service related'
    param :form, 'payment[active]', :boolean, :optional, 'State of activation'
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

  swagger_api :show do
    summary "Fetches detailed Payment Method"
    param :path, :id, :integer, :optional, "Payment Method Id"
    response :unauthorized
    response :not_found
  end
  swagger_api :me do
    summary "Fetches mine Payment Method"
    param :path, :id, :integer, :optional, "Payment Method Id"
    response :unauthorized
  end

  swagger_api :find_user do
    summary "Fetches Payment Methods of user"
    param :path, :id, :integer, :optional, "User Id"
    response :unauthorized
  end




  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
    render json: @payments
  end

  def active
    @payments = Payment.where(active: true)
    render json: @payments
  end

  def me
    @payments = @user.payments
    render json: @payments
  end

  def find_user
    user = User.find_by(id: params[:user][:id])
    payments = user.payments.where(active: true)
    render json: payments
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    render json: @payment
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)    
    if @payment.save
      render json: @payment, status: :created, location: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    if @payment.update(payment_params)
      render json: @payment, status: :ok, location: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
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
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:uuid, :total, :sub_total, :taxes, :transaction_code, :observation, :coupon_id, :coupon_code, :coupon_amount, :user_payment_method_id, :payment_method_id, :statu_id, :service_id, :is_service, :user_id, :active)
    end
end
