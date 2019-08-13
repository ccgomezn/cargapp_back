class Api::V1::PrizesController < ApplicationController
  before_action :set_prize, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

  # GET /prizes
  # GET /prizes.json
  def index
    @prizes = Prize.all

    @result = []
    @prizes.each do |prize|
      @obj = {
        id: prize.id,
        name: prize.name,
        code: prize.code,
        point: prize.point,
        description: prize.description,
        body: prize.body,
        expire_date: prize.expire_date,
        user_id: prize.user_id,
        active: prize.active,
        image: prize.image.attached? ? url_for(prize.image) : nil,
        media: prize.media.attached? ? url_for(prize.media) : nil
      }
      @result << @obj
    end
    render json: @result
  end

  def active
    @prizes = Prize.where(active: true)

    @result = []
    @prizes.each do |prize|
      @obj = {
        id: prize.id,
        name: prize.name,
        code: prize.code,
        point: prize.point,
        description: prize.description,
        body: prize.body,
        expire_date: prize.expire_date,
        user_id: prize.user_id,
        active: prize.active,
        image: prize.image.attached? ? url_for(prize.image) : nil,
        media: prize.media.attached? ? url_for(prize.media) : nil
      }
      @result << @obj
    end
    render json: @result
  end

  # GET /prizes/1
  # GET /prizes/1.json
  def show
    @obj = {
      id: @prize.id,
      name: @prize.name,
      code: @prize.code,
      point: @prize.point,
      description: @prize.description,
      body: @prize.body,
      expire_date: @prize.expire_date,
      user_id: @prize.user_id,
      active: @prize.active,
      image: @prize.image.attached? ? url_for(@prize.image) : nil,
      media: @prize.media.attached? ? url_for(@prize.media) : nil
    }
    render json: @obj
  end

  # POST /prizes
  # POST /prizes.json
  def create
    @prize = Prize.new(prize_params)
    if @prize.save
      @obj = {
        id: @prize.id,
        name: @prize.name,
        code: @prize.code,
        point: @prize.point,
        description: @prize.description,
        body: @prize.body,
        expire_date: @prize.expire_date,
        user_id: @prize.user_id,
        active: @prize.active,
        image: @prize.image.attached? ? url_for(@prize.image) : nil,
        media: @prize.media.attached? ? url_for(@prize.media) : nil
      }
      render json: @obj, status: :created, location: @obj
    else
      render json: @prize.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /prizes/1
  # PATCH/PUT /prizes/1.json
  def update
    if @prize.update(prize_params)

      params.require(:prize).permit(:name, :code, :point, :description, :body, :image, :media, :expire_date, :user_id, :active)

      @obj = {
        id: @prize.id,
        name: @prize.name,
        code: @prize.code,
        point: @prize.point,
        description: @prize.description,
        body: @prize.body,
        expire_date: @prize.expire_date,
        user_id: @prize.user_id,
        active: @prize.active,
        image: @prize.image.attached? ? url_for(@prize.image) : nil,
        media: @prize.media.attached? ? url_for(@prize.media) : nil
      }
      render json: @obj, status: :ok, location: @prize
    else
      render json: @prize.errors, status: :unprocessable_entity
    end 
  end

  # DELETE /prizes/1
  # DELETE /prizes/1.json
  def destroy
    @prize.destroy
  end

  private

    def set_user
      @user = User.all.first #User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_prize
      @prize = Prize.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prize_params
      params.require(:prize).permit(:name, :code, :point, :description, :body, :image, :media, :expire_date, :user_id, :active)
    end
end
