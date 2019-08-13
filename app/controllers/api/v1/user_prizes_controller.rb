class Api::V1::UserPrizesController < ApplicationController
  before_action :set_user_prize, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

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
      @user = User.all.first #User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
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
