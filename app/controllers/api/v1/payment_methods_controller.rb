class Api::V1::PaymentMethodsController < ApplicationController
  before_action :set_payment_method, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

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
