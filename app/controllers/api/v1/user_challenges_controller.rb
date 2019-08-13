class Api::V1::UserChallengesController < ApplicationController
  before_action :set_user_challenge, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

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
      @user = User.all.first #User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
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
