class Api::V1::UserPaymentMethodsController < ApplicationController
  before_action :set_user_payment_method, only: [:show, :edit, :update, :destroy]
  before_action :doorkeeper_authorize!
  before_action :set_user

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
      @user = User.all.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
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
