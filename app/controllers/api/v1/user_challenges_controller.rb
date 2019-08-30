class Api::V1::UserChallengesController < ApplicationController
  before_action :set_user_challenge, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  swagger_controller :userChallenges, 'User - Challenges Relation Management'

  swagger_api :index do
    summary 'Fetches all User-Challenge items'
    notes 'This lists all the User-Challenges'
  end

  swagger_api :active do
    summary 'Fetches all active User-Challenge items'
    notes 'This lists all the active User-Challenges'
  end

  swagger_api :create do
    summary 'Creates a new User-Challenge'
    param :form, 'user_challenge[position]', :integer, :required, 'Position of user-challenge'
    param :form, 'user_challenge[point]', :integer, :required, 'Points on challenge'
    param :form, 'user_challenge[challenge_id]', :integer, :required, 'Id of challenge associated'
    param :form, 'user_challenge[user_id]', :integer, :required, 'Id of user associated'
    param :form, 'user_challenge[active]', :boolean, :required, 'Activation state'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing User-Challenge'
    param :path, :id, :integer, :required, "User-Challenge Id"
    param :form, 'user_challenge[position]', :integer, :optional, 'Position of user-challenge'
    param :form, 'user_challenge[point]', :integer, :optional, 'Points on challenge'
    param :form, 'user_challenge[challenge_id]', :integer, :optional, 'Id of challenge associated'
    param :form, 'user_challenge[user_id]', :integer, :optional, 'Id of user associated'
    param :form, 'user_challenge[active]', :boolean, :optional, 'Activation state'
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing User-Challenge"
    param :path, :id, :integer, :optional, "User-Challenge Id"
    response :unauthorized
    response :not_found
  end

  # GET /user_challenges
  # GET /user_challenges.json
  def index
    @user_challenges = UserChallenge.all
    render json: @user_challenges
  end

  def active
    @user_challenges = UserChallenge.where(active: true)
    render json: @user_challenges
  end

  def me
    @user_challenges = @user.user_challenges
    render json: @user_challenges
  end

  # GET /user_challenges/1
  # GET /user_challenges/1.json
  def show
    render json: @user_challenge
  end

  # POST /user_challenges
  # POST /user_challenges.json
  def create
    @user_challenge = UserChallenge.new(user_challenge_params)

    if @user_challenge.save
      render json: @user_challenge, status: :created, location: @user_challenge      
    else
      render json: @user_challenge.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_challenges/1
  # PATCH/PUT /user_challenges/1.json
  def update
    if @user_challenge.update(user_challenge_params)
      render json: @user_challenge
    else
      render json: @user_challenge.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_challenges/1
  # DELETE /user_challenges/1.json
  def destroy
    @user_challenge.destroy
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
    def set_user_challenge
      @user_challenge = UserChallenge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_challenge_params
      params.require(:user_challenge).permit(:position, :point, :challenge_id, :user_id, :active)
    end
end
