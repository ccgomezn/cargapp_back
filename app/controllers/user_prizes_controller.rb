class UserPrizesController < ApplicationController
  before_action :set_user_prize, only: [:show, :edit, :update, :destroy]

  # GET /user_prizes
  # GET /user_prizes.json
  def index
    @user_prizes = UserPrize.all
  end

  # GET /user_prizes/1
  # GET /user_prizes/1.json
  def show
  end

  # GET /user_prizes/new
  def new
    @user_prize = UserPrize.new
  end

  # GET /user_prizes/1/edit
  def edit
  end

  # POST /user_prizes
  # POST /user_prizes.json
  def create
    @user_prize = UserPrize.new(user_prize_params)

    respond_to do |format|
      if @user_prize.save
        format.html { redirect_to @user_prize, notice: 'User prize was successfully created.' }
        format.json { render :show, status: :created, location: @user_prize }
      else
        format.html { render :new }
        format.json { render json: @user_prize.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_prizes/1
  # PATCH/PUT /user_prizes/1.json
  def update
    respond_to do |format|
      if @user_prize.update(user_prize_params)
        format.html { redirect_to @user_prize, notice: 'User prize was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_prize }
      else
        format.html { render :edit }
        format.json { render json: @user_prize.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_prizes/1
  # DELETE /user_prizes/1.json
  def destroy
    @user_prize.destroy
    respond_to do |format|
      format.html { redirect_to user_prizes_url, notice: 'User prize was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_prize
      @user_prize = UserPrize.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_prize_params
      params.require(:user_prize).permit(:point, :prize_id, :expire_date, :user_id, :active)
    end
end
