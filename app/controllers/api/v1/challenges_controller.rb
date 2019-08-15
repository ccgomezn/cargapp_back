class Api::V1::ChallengesController < ApplicationController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

  swagger_controller :challenges, 'Challenges Management'

  swagger_api :index do
    summary 'Fetches all Challenges items'
    notes 'This lists all the challenges'
  end

  swagger_api :active do
    summary 'Fetches all active Challenges items'
    notes 'This lists all the active challenges'
  end

  swagger_api :create do
    summary 'Creates a new Challenge'
    param :form, 'challenge[name]', :string, :required, 'Name'
    param :form, 'challenge[body]', :string, :required, 'Body'
    param :form, 'challenge[image]', :file, :required, 'Image'
    param :form, 'challenge[point]', :string, :required, 'Points related to challenge'
    param :form, 'challenge[user_id]', :integer, :required, 'Id of user associated to challenge'
    param :form, 'challenge[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Challenge'
    param :path, :id, :integer, :required, "Challenge Id"
    param :form, 'challenge[name]', :string, :optional, 'Name'
    param :form, 'challenge[body]', :string, :optional, 'Body'
    param :form, 'challenge[image]', :file, :optional, 'Image'
    param :form, 'challenge[point]', :string, :optional, 'Points related to challenge'
    param :form, 'challenge[user_id]', :integer, :optional, 'Id of user associated to challenge'
    param :form, 'challenge[active]', :boolean, :optional, 'State of activation'
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Challenge"
    param :path, :id, :integer, :optional, "Challenge Id"
    response :unauthorized
    response :not_found
  end
  # GET /challenges
  # GET /challenges.json
  def index
    @challenges = Challenge.all

    @result = []
    @challenges.each do |challenge|
      @obj = {
        id: challenge.id,
        name: challenge.name,
        body: challenge.body,
        point: challenge.point,
        image: challenge.image.attached? ? url_for(challenge.image) : nil,
        user_id: challenge.user_id,
        active: challenge.active,
        created_at: challenge.created_at,
        updated_at: challenge.updated_at
      }
      @result << @obj
    end
    render json: @result
  end
  # permit(:name, :body, :image, :point, :user_id, :active)

  def active
    @challenges = Challenge.where(active: true)

    @result = []
    @challenges.each do |challenge|
      @obj = {
        id: challenge.id,
        name: challenge.name,
        body: challenge.body,
        point: challenge.point,
        image: challenge.image.attached? ? url_for(challenge.image) : nil,
        user_id: challenge.user_id,
        active: challenge.active,
        created_at: challenge.created_at,
        updated_at: challenge.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  def me
    @challenges = @user.challenges

    @result = []
    @challenges.each do |challenge|
      @obj = {
        id: challenge.id,
        name: challenge.name,
        body: challenge.body,
        point: challenge.point,
        image: challenge.image.attached? ? url_for(challenge.image) : nil,
        user_id: challenge.user_id,
        active: challenge.active,
        created_at: challenge.created_at,
        updated_at: challenge.updated_at
      }
      @result << @obj
    end
    render json: @result
  end


  # GET /challenges/1
  # GET /challenges/1.json
  def show
    @result = []
    @obj = {
      id: @challenge.id,
      name: @challenge.name,
      body: @challenge.body,
      point: @challenge.point,
      image: @challenge.image.attached? ? url_for(@challenge.image) : nil,
      user_id: @challenge.user_id,
      active: @challenge.active,
      created_at: @challenge.created_at,
      updated_at: @challenge.updated_at
    }
    @result << @obj
    render json: @result
  end

  # POST /challenges
  # POST /challenges.json
  def create
    @challenge = Challenge.new(challenge_params)

    if @challenge.save
      @obj = {
        id: @challenge.id,
        name: @challenge.name,
        body: @challenge.body,
        point: @challenge.point,
        image: @challenge.image.attached? ? url_for(@challenge.image) : nil,
        user_id: @challenge.user_id,
        active: @challenge.active,
        created_at: @challenge.created_at,
        updated_at: @challenge.updated_at
      }
      render json: @obj, status: :created, location: @obj
    else
      render json: @challenge.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /challenges/1
  # PATCH/PUT /challenges/1.json
  def update
    if @challenge.update(challenge_params)
      @obj = {
        id: @challenge.id,
        name: @challenge.name,
        body: @challenge.body,
        point: @challenge.point,
        image: @challenge.image.attached? ? url_for(@challenge.image) : nil,
        user_id: @challenge.user_id,
        active: @challenge.active,
        created_at: @challenge.created_at,
        updated_at: @challenge.updated_at
      }

      render json: @obj
    else
      render json: @challenge.errors, status: :unprocessable_entity
    end
  end

  # DELETE /challenges/1
  # DELETE /challenges/1.json
  def destroy
    @challenge.destroy
  end

  private

    def set_user
      @user = User.all.first #User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def challenge_params
      params.require(:challenge).permit(:name, :body, :image, :point, :user_id, :active)
    end
end
