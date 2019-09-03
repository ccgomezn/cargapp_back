class Api::V1::CargappPaymentsController < ApplicationController
  before_action :set_cargapp_payment, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  # GET /cargapp_payments
  # GET /cargapp_payments.json
  def index
    @cargapp_payments = CargappPayment.all
    render json: @cargapp_payments
  end

  def active
    @cargapp_payments = CargappPayment.where(active: true)
    render json: @cargapp_payments
  end

  def me
    @cargapp_payments = @user.cargapp_payments
    render json: @cargapp_payments
  end  

  # GET /cargapp_payments/1
  # GET /cargapp_payments/1.json
  def show
    render json: @cargapp_payment
  end

  # POST /cargapp_payments
  # POST /cargapp_payments.json
  def create
    @cargapp_payment = CargappPayment.new(cargapp_payment_params)
    if @cargapp_payment.save
      render json: @cargapp_payment, status: :created, location: @cargapp_payment
    else
      render json: @cargapp_payment.errors, status: :unprocessable_entity
    end    
  end

  # PATCH/PUT /cargapp_payments/1
  # PATCH/PUT /cargapp_payments/1.json
  def update
    if @cargapp_payment.update(cargapp_payment_params)
      render json: @cargapp_payment, status: :ok, location: @cargapp_payment
    else
      render json: @cargapp_payment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cargapp_payments/1
  # DELETE /cargapp_payments/1.json
  def destroy
    @cargapp_payment.destroy
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
    def set_cargapp_payment
      @cargapp_payment = CargappPayment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cargapp_payment_params
      params.require(:cargapp_payment).permit(:uuid, :amount, :transaction_code, :observation, :payment_method_id, :statu_id, :generator_id, :receiver_id, :bank_account_id, :service_id, :company_id, :user_id, :active)
    end
end
