class Api::V1::BankAccountsController < ApplicationController
  before_action :set_bank_account, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user



  swagger_controller :bankAccounts, 'Bank Accounts Management'

  swagger_api :index do
    summary 'Fetches all Bank Accounts items'
    notes 'This lists all the bank accounts'
  end

  swagger_api :me do
    summary 'Fetches mine Bank Accounts items'
    notes 'This lists mine the bank accounts'
  end

  swagger_api :show do
    summary 'Fetches detailed Bank Accounts items'
    param :path, :id, :integer, :required, "Bank Account Id"
    notes 'This lists detailed bank accounts'
  end

  swagger_api :active do
    summary 'Fetches all active Bank accounts items'
    notes 'This lists all the active bank accounts'
  end

  swagger_api :create do
    summary 'Creates a new Bank Account'
    param :form, "bank_account[account_number]", :string, :required, 'Account Number'
    param :form, "bank_account[account_type]", :string, :required, 'Account Type'
    param :form, "bank_account[bank]", :string, :required, 'Bank'
    param :form, "bank_account[user_id]", :string, :required, 'Id related to user'
    param :form, "bank_account[statu_id]", :string, :required, 'Id related to status'
    param :form, "bank_account[active]", :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Bank Account'
    param :path, :id, :integer, :required, "Bank Account Id"
    param :form, "bank_account[account_number]", :string, :optional, 'Account Number'
    param :form, "bank_account[account_type]", :string, :optional, 'Account Type'
    param :form, "bank_account[bank]", :string, :optional, 'Bank'
    param :form, "bank_account[user_id]", :string, :optional, 'Id related to user'
    param :form, "bank_account[statu_id]", :string, :optional, 'Id related to status'
    param :form, "bank_account[active]", :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Bank Account"
    param :path, :id, :integer, :optional, "Bank Account Id"
    response :unauthorized
    response :not_found
  end

  # GET /bank_accounts
  # GET /bank_accounts.json
  def index
    @bank_accounts = BankAccount.all
    render json: @bank_accounts
  end

  def active
    @bank_accounts = BankAccount.where(active: true)
    render json: @bank_accounts
  end

  def me
    @bank_accounts = @user.bank_accounts
    render json: @bank_accounts
  end

  # GET /bank_accounts/1
  # GET /bank_accounts/1.json
  def show
    render json: @bank_account
  end

  # POST /bank_accounts
  # POST /bank_accounts.json
  def create
    @bank_account = BankAccount.new(bank_account_params)
    if @bank_account.save
      render json: @bank_account, status: :created, location: @bank_account
    else
      render json: @bank_account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bank_accounts/1
  # PATCH/PUT /bank_accounts/1.json
  def update
    if @bank_account.update(bank_account_params)
      render json: @bank_account, status: :ok, location: @bank_account
    else  
      render json: @bank_account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bank_accounts/1
  # DELETE /bank_accounts/1.json
  def destroy
    @bank_account.destroy    
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
    def set_bank_account
      @bank_account = BankAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_account_params
      params.require(:bank_account).permit(:account_number, :account_type, :bank, :user_id, :statu_id, :active)
    end
end
