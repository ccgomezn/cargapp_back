class Api::V1::CompanyUsersController < ApplicationController
  before_action :set_company_user, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  # GET /company_users
  # GET /company_users.json
  def index
    @company_users = CompanyUser.all
    render json: @company_users
  end

  def active
    @company_users = CompanyUser.where(active: true)
    render json: @company_users
  end

  def me
    @company_users = @user.companies
    company_users = []
    @company_users.each do |company|
      company_users << company.company_users
    end 
    render json: @company_users
  end

  def find_company
    @company_users = CompanyUser.where(company_id: params[:id])
    users = []
    @company_users.each do |company|
      user_obj = {
        user:  company.user
        #profile:  company.user.profile
      }
      users << company.user
    end 
    render json: users || @company_users
  end

  # GET /company_users/1
  # GET /company_users/1.json
  def show
    render json: @company_user
  end

  # POST /company_users
  # POST /company_users.json
  def create
    @company_user = CompanyUser.new(company_user_params)
    if @company_user.save
      render json: @company_user, status: :created, location: @company_user
    else
      render json: @company_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /company_users/1
  # PATCH/PUT /company_users/1.json
  def update    
    if @company_user.update(company_user_params)
      render json: @company_user
      # 'company was successfully updated.'
    else
      render json: @company_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /company_users/1
  # DELETE /company_users/1.json
  def destroy
    @company_user.destroy
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
    def set_company_user
      @company_user = CompanyUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_user_params
      params.require(:company_user).permit(:company_id, :user_id, :active)
    end
end
