# frozen_string_literal: true

class VehicleBankAccountsController < ApplicationController
  before_action :set_vehicle_bank_account, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /vehicle_bank_accounts
  # GET /vehicle_bank_accounts.json
  def index
    @vehicle_bank_accounts = VehicleBankAccount.all
  end

  # GET /vehicle_bank_accounts/1
  # GET /vehicle_bank_accounts/1.json
  def show; end

  # GET /vehicle_bank_accounts/new
  def new
    @vehicle_bank_account = VehicleBankAccount.new
  end

  # GET /vehicle_bank_accounts/1/edit
  def edit; end

  # POST /vehicle_bank_accounts
  # POST /vehicle_bank_accounts.json
  def create
    @vehicle_bank_account = VehicleBankAccount.new(vehicle_bank_account_params)

    respond_to do |format|
      if @vehicle_bank_account.save
        format.html { redirect_to @vehicle_bank_account, notice: 'Vehicle bank account was successfully created.' }
        format.json { render :show, status: :created, location: @vehicle_bank_account }
      else
        format.html { render :new }
        format.json { render json: @vehicle_bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicle_bank_accounts/1
  # PATCH/PUT /vehicle_bank_accounts/1.json
  def update
    respond_to do |format|
      if @vehicle_bank_account.update(vehicle_bank_account_params)
        format.html { redirect_to @vehicle_bank_account, notice: 'Vehicle bank account was successfully updated.' }
        format.json { render :show, status: :ok, location: @vehicle_bank_account }
      else
        format.html { render :edit }
        format.json { render json: @vehicle_bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicle_bank_accounts/1
  # DELETE /vehicle_bank_accounts/1.json
  def destroy
    @vehicle_bank_account.destroy
    respond_to do |format|
      format.html { redirect_to vehicle_bank_accounts_url, notice: 'Vehicle bank account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vehicle_bank_account
    @vehicle_bank_account = VehicleBankAccount.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vehicle_bank_account_params
    params.require(:vehicle_bank_account).permit(:account_number, :account_type, :bank, :user_id, :vehicle_id, :statu_id, :certificate, :active, :approved)
  end
end
