class UserPaymentMethodsController < ApplicationController
  before_action :set_user_payment_method, only: [:show, :edit, :update, :destroy]

  # GET /user_payment_methods
  # GET /user_payment_methods.json
  def index
    @user_payment_methods = UserPaymentMethod.all
  end

  # GET /user_payment_methods/1
  # GET /user_payment_methods/1.json
  def show
  end

  # GET /user_payment_methods/new
  def new
    @user_payment_method = UserPaymentMethod.new
  end

  # GET /user_payment_methods/1/edit
  def edit
  end

  # POST /user_payment_methods
  # POST /user_payment_methods.json
  def create
    @user_payment_method = UserPaymentMethod.new(user_payment_method_params)

    respond_to do |format|
      if @user_payment_method.save
        format.html { redirect_to @user_payment_method, notice: 'User payment method was successfully created.' }
        format.json { render :show, status: :created, location: @user_payment_method }
      else
        format.html { render :new }
        format.json { render json: @user_payment_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_payment_methods/1
  # PATCH/PUT /user_payment_methods/1.json
  def update
    respond_to do |format|
      if @user_payment_method.update(user_payment_method_params)
        format.html { redirect_to @user_payment_method, notice: 'User payment method was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_payment_method }
      else
        format.html { render :edit }
        format.json { render json: @user_payment_method.errors, status: :unprocessable_entity }
      end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_user_payment_method
      @user_payment_method = UserPaymentMethod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_payment_method_params
      params.require(:user_payment_method).permit(:email, :uuid, :token, :card_number, :expiration, :cvv, :observation, :user_id, :payment_method_id, :active)
    end
end
