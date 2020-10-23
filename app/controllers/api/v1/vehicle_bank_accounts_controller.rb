# frozen_string_literal: true

class Api::V1::VehicleBankAccountsController < ApplicationController
  before_action :set_vehicle_bank_account, only: %i[show edit update destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  # GET /vehicle_bank_accounts
  # GET /vehicle_bank_accounts.json
  def index
    @vehicle_bank_accounts = VehicleBankAccount.all
    @result = []
    @vehicle_bank_accounts.each do |bank_accounts|
      @obj = {
        id: bank_accounts.id,
        account_number: bank_accounts.account_number,
        account_type: bank_accounts.account_type,
        bank: bank_accounts.bank,
        statu_id: bank_accounts.statu_id,
        user_id: bank_accounts.user_id,
        vehicle_id: bank_accounts.vehicle_id,
        active: bank_accounts.active,
        approved: bank_accounts.approved,
        certificate: bank_accounts.certificate.attached? ? url_for(bank_accounts.certificate) : nil,
        created_at: bank_accounts.created_at,
        updated_at: bank_accounts.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  def active
    @vehicle_bank_accounts = VehicleBankAccount.where(active: true)
    @result = []
    @vehicle_bank_accounts.each do |bank_accounts|
      @obj = {
        id: bank_accounts.id,
        account_number: bank_accounts.account_number,
        account_type: bank_accounts.account_type,
        bank: bank_accounts.bank,
        statu_id: bank_accounts.statu_id,
        user_id: bank_accounts.user_id,
        vehicle_id: bank_accounts.vehicle_id,
        active: bank_accounts.active,
        approved: bank_accounts.approved,
        certificate: bank_accounts.certificate.attached? ? url_for(bank_accounts.certificate) : nil,
        created_at: bank_accounts.created_at,
        updated_at: bank_accounts.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  def me
    @vehicle_bank_accounts = @user.vehicle_bank_accounts
    @result = []
    @vehicle_bank_accounts.each do |bank_accounts|
      @obj = {
        id: bank_accounts.id,
        account_number: bank_accounts.account_number,
        account_type: bank_accounts.account_type,
        bank: bank_accounts.bank,
        statu_id: bank_accounts.statu_id,
        user_id: bank_accounts.user_id,
        vehicle_id: bank_accounts.vehicle_id,
        active: bank_accounts.active,
        approved: bank_accounts.approved,
        certificate: bank_accounts.certificate.attached? ? url_for(bank_accounts.certificate) : nil,
        created_at: bank_accounts.created_at,
        updated_at: bank_accounts.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  def vehicle
    @vehicle_bank_accounts = VehicleBankAccount.where(active: true, vehicle_id: params['id'])
    @result = []
    @vehicle_bank_accounts.each do |bank_accounts|
      @obj = {
        id: bank_accounts.id,
        account_number: bank_accounts.account_number,
        account_type: bank_accounts.account_type,
        bank: bank_accounts.bank,
        statu_id: bank_accounts.statu_id,
        user_id: bank_accounts.user_id,
        vehicle_id: bank_accounts.vehicle_id,
        active: bank_accounts.active,
        approved: bank_accounts.approved,
        certificate: bank_accounts.certificate.attached? ? url_for(bank_accounts.certificate) : nil,
        created_at: bank_accounts.created_at,
        updated_at: bank_accounts.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  # GET /vehicle_bank_accounts/1
  # GET /vehicle_bank_accounts/1.json
  def show
    @obj = {
      id: @vehicle_bank_account.id,
      account_number: @vehicle_bank_account.account_number,
      account_type: @vehicle_bank_account.account_type,
      bank: @vehicle_bank_account.bank,
      statu_id: @vehicle_bank_account.statu_id,
      user_id: @vehicle_bank_account.user_id,
      vehicle_id: @vehicle_bank_account.vehicle_id,
      active: @vehicle_bank_account.active,
      approved: @vehicle_bank_account.approved,
      certificate: @vehicle_bank_account.certificate.attached? ? url_for(@vehicle_bank_account.certificate) : nil,
      created_at: @vehicle_bank_account.created_at,
      updated_at: @vehicle_bank_account.updated_at
    }

    render json: @obj
  end

  # POST /vehicle_bank_accounts
  # POST /vehicle_bank_accounts.json
  def create
    @vehicle_bank_account = VehicleBankAccount.new(vehicle_bank_account_params)

    if @vehicle_bank_account.save
      @obj = {
        id: @vehicle_bank_account.id,
        account_number: @vehicle_bank_account.account_number,
        account_type: @vehicle_bank_account.account_type,
        bank: @vehicle_bank_account.bank,
        statu_id: @vehicle_bank_account.statu_id,
        user_id: @vehicle_bank_account.user_id,
        vehicle_id: @vehicle_bank_account.vehicle_id,
        active: @vehicle_bank_account.active,
        approved: @vehicle_bank_account.approved,
        certificate: @vehicle_bank_account.certificate.attached? ? url_for(@vehicle_bank_account.certificate) : nil,
        created_at: @vehicle_bank_account.created_at,
        updated_at: @vehicle_bank_account.updated_at
      }
      render json: @obj, status: :created, location: @vehicle_bank_account
    else
      render json: @vehicle_bank_account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vehicle_bank_accounts/1
  # PATCH/PUT /vehicle_bank_accounts/1.json
  def update
    if @vehicle_bank_account.update(vehicle_bank_account_params)
      @obj = {
        id: @vehicle_bank_account.id,
        account_number: @vehicle_bank_account.account_number,
        account_type: @vehicle_bank_account.account_type,
        bank: @vehicle_bank_account.bank,
        statu_id: @vehicle_bank_account.statu_id,
        user_id: @vehicle_bank_account.user_id,
        vehicle_id: @vehicle_bank_account.vehicle_id,
        active: @vehicle_bank_account.active,
        approved: @vehicle_bank_account.approved,
        certificate: @vehicle_bank_account.certificate.attached? ? url_for(@vehicle_bank_account.certificate) : nil,
        created_at: @vehicle_bank_account.created_at,
        updated_at: @vehicle_bank_account.updated_at
      }
      render json: @obj, status: :ok, location: @vehicle_bank_account
    else
      render json: @vehicle_bank_account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vehicle_bank_accounts/1
  # DELETE /vehicle_bank_accounts/1.json
  def destroy
    @vehicle_bank_account.destroy
  end

  private

  def set_user
    @user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    permissions
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

      has_permission = true if if_super

      if has_permission
        true
      else
        response = { response: 'Does not have permissions' }
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
        response = { response: 'Does not have permissions' }
        render json: response, status: :unprocessable_entity
      end
    end
end

  def if_super
    @if_super = (User.is_super?(@user) if @user) || false
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_vehicle_bank_account
    @vehicle_bank_account = VehicleBankAccount.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vehicle_bank_account_params
    params.require(:vehicle_bank_account).permit(:account_number, :account_type, :bank, :user_id, :vehicle_id, :statu_id, :certificate, :active, :approved)
  end
end
