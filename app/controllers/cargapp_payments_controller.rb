class CargappPaymentsController < ApplicationController
  before_action :set_cargapp_payment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /cargapp_payments
  # GET /cargapp_payments.json
  def index
    @cargapp_payments = CargappPayment.all
  end

  # GET /cargapp_payments/1
  # GET /cargapp_payments/1.json
  def show
  end

  # GET /cargapp_payments/new
  def new
    @cargapp_payment = CargappPayment.new
  end

  # GET /cargapp_payments/1/edit
  def edit
  end

  # POST /cargapp_payments
  # POST /cargapp_payments.json
  def create
    @cargapp_payment = CargappPayment.new(cargapp_payment_params)

    respond_to do |format|
      if @cargapp_payment.save
        format.html { redirect_to @cargapp_payment, notice: 'Cargapp payment was successfully created.' }
        format.json { render :show, status: :created, location: @cargapp_payment }
      else
        format.html { render :new }
        format.json { render json: @cargapp_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cargapp_payments/1
  # PATCH/PUT /cargapp_payments/1.json
  def update
    respond_to do |format|
      if @cargapp_payment.update(cargapp_payment_params)
        format.html { redirect_to @cargapp_payment, notice: 'Cargapp payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @cargapp_payment }
      else
        format.html { render :edit }
        format.json { render json: @cargapp_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cargapp_payments/1
  # DELETE /cargapp_payments/1.json
  def destroy
    @cargapp_payment.destroy
    respond_to do |format|
      format.html { redirect_to cargapp_payments_url, notice: 'Cargapp payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cargapp_payment
      @cargapp_payment = CargappPayment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cargapp_payment_params
      params.require(:cargapp_payment).permit(:uuid, :amount, :transaction_code, :observation, :payment_method_id, :statu_id, :generator_id, :receiver_id, :bank_account_id, :service_id, :company_id, :user_id, :active)
    end
end
