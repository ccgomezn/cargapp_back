class Api::V1::UserPrizesController < ApplicationController
  before_action :set_user_prize, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  swagger_controller :userPrizes, 'Prizes-Users relation Management'

  swagger_api :index do
    summary 'Fetches all user-prizes items'
    notes 'This lists all the user-prizes'
  end

  swagger_api :active do
    summary 'Fetches all active user-prizes items'
    notes 'This lists all the active user-prizes'
  end

  swagger_api :create do
    summary 'Creates a new user-prizes'
    param :form, 'user_prize[point]', :string, :required, 'Points related to prize'
    param :form, 'user_prize[expire_date]', :string, :required, 'Expiration date of user_prize'
    param :form, 'user_prize[prize_id]', :integer, :required, 'Id of prize related'
    param :form, 'user_prize[user_id]', :integer, :required, 'Id of user related'
    param :form, 'user_prize[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing User-Prize'
    param :path, :id, :integer, :required, "User-Prize Id"
    param :form, 'user_prize[point]', :string, :optional, 'Points related to prize'
    param :form, 'user_prize[expire_date]', :string, :optional, 'Expiration date of user_prize'
    param :form, 'user_prize[prize_id]', :integer, :optional, 'Id of prize related'
    param :form, 'user_prize[user_id]', :integer, :optional, 'Id of user related'
    param :form, 'user_prize[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing User-Prize"
    param :path, :id, :integer, :optional, "User-Prize Id"
    response :unauthorized
    response :not_found
  end

  swagger_api :show do
    summary "Shows an existing User-Prize"
    param :path, :id, :integer, :optional, "User-Prize Id"
    response :unauthorized
    response :not_found
  end

  swagger_api :me do
    summary "Shows mine User-Prize"
    response :unauthorized
  end
  # GET /user_prizes
  # GET /user_prizes.json
  def index
    @user_prizes = UserPrize.all
    
    render json: @user_prizes
  end

  def active
    @user_prizes = UserPrize.where(active: true)
    
    render json: @user_prizes
  end

  def me
    @user_prizes = @user.user_prizes
    
    render json: @user_prizes
  end

  # GET /user_prizes/1
  # GET /user_prizes/1.json
  def show
    render json: @user_prize
  end

  # POST /user_prizes
  # POST /user_prizes.json
  def create
    @user_prize = UserPrize.new(user_prize_params)
    if @user_prize.save
      render json: @user_prize, status: :created, location: @user_prize
    else
      render json: @user_prize.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_prizes/1
  # PATCH/PUT /user_prizes/1.json
  def update
    if @user_prize.update(user_prize_params)
      render json: @user_prize, status: :ok, location: @user_prize
    else
      render json: @user_prize.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_prizes/1
  # DELETE /user_prizes/1.json
  def destroy
    @user_prize.destroy
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
    def set_user_prize
      @user_prize = UserPrize.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_prize_params
      params.require(:user_prize).permit(:point, :prize_id, :expire_date, :user_id, :active)
    end
end
