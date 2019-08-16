class Api::V1::PrizesController < ApplicationController
  before_action :set_prize, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

  swagger_controller :prizes, 'Prizes Management'

  swagger_api :index do
    summary 'Fetches all Prize items'
    notes 'This lists all the prizes'
  end

  swagger_api :active do
    summary 'Fetches all active Prize items'
    notes 'This lists all the active prizes'
  end

  swagger_api :create do
    summary 'Creates a new Prize'
    param :form, 'prize[name]', :string, :required, 'Name'
    param :form, 'prize[code]', :string, :required, 'Code'
    param :form, 'prize[point]', :integer, :required, 'Points on prize'
    param :form, 'prize[description]', :string, :required, 'Description'
    param :form, 'prize[body]', :string, :required, 'Body'
    param :form, 'prize[image]', :file, :required, 'Image of prize'
    param :form, 'prize[media]', :file, :required, 'Media of prize'
    param :form, 'prize[expire_date]', :string, :required, 'Expiration date of prize'
    param :form, 'prize[user_id]', :integer, :required, 'Id of user related'
    param :form, 'prize[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Prize'
    param :path, :id, :integer, :required, "Prize Id"
    param :form, 'prize[name]', :string, :optional, 'Name'
    param :form, 'prize[code]', :string, :optional, 'Code'
    param :form, 'prize[point]', :integer, :optional, 'Points on prize'
    param :form, 'prize[description]', :string, :optional, 'Description'
    param :form, 'prize[body]', :string, :optional, 'Body'
    param :form, 'prize[image]', :file, :optional, 'Image of prize'
    param :form, 'prize[media]', :file, :optional, 'Media of prize'
    param :form, 'prize[expire_date]', :string, :optional, 'Expiration date of prize'
    param :form, 'prize[user_id]', :integer, :optional, 'Id of user related'
    param :form, 'prize[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Prize"
    param :path, :id, :integer, :optional, "Prize Id"
    response :unauthorized
    response :not_found
  end
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
