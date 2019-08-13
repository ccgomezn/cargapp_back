class Api::V1::ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all

    @result = []
    @profiles.each do |profile|
      @obj = {
        id: profile.id,
        firt_name: profile.firt_name,
        last_name: profile.last_name,
        avatar: profile.avatar.attached? ? url_for(profile.avatar) : nil,
        phone: profile.phone,
        birth_date: profile.birth_date,
        document_id: profile.document_id,
        document_type_id: profile.document_type_id,
        user_id: profile.user_id,
        created_at: profile.created_at,
        updated_at: profile.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  def active
    @profiles = Profile.all

    @result = []
    @profiles.each do |profile|
      # Validar que el usuario este activado y aprobado
      if profile.user.created_at != profile.user.updated_at 
        @obj = {
          id: profile.id,
          firt_name: profile.firt_name,
          last_name: profile.last_name,
          avatar: profile.avatar.attached? ? url_for(profile.avatar) : nil,
          phone: profile.phone,
          birth_date: profile.birth_date,
          document_id: profile.document_id,
          document_type_id: profile.document_type_id,
          user_id: profile.user_id,
          created_at: profile.created_at,
          updated_at: profile.updated_at
        }
        @result << @obj
      end
    end
    render json: @result
  end

  def me
    if @user.profile
      @profile = @user.profile
      @result = []
      @obj = {
        id: @profile.id,
        firt_name: @profile.firt_name,
        last_name: @profile.last_name,
        avatar: @profile.avatar.attached? ? url_for(@profile.avatar) : nil,
        phone: @profile.phone,
        birth_date: @profile.birth_date,
        document_id: @profile.document_id,
        document_type_id: @profile.document_type_id,
        user_id: @profile.user_id,
        created_at: @profile.created_at,
        updated_at: @profile.updated_at
      }
      @obj_result = {
        profile: @obj,
        user: @user
      }
      @result << @obj_result
      render json: @result
    else
      @obj = {
        user: @user,
        message: "has no profile"
      }
      render json: @obj, status: :unprocessable_entity
    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    profile = {
      id: @profile.id,
      firt_name: @profile.firt_name,
      last_name: @profile.last_name,
      avatar: @profile.avatar.attached? ? url_for(@profile.avatar) : nil,
      phone: @profile.phone,
      birth_date: @profile.birth_date,
      document_id: @profile.document_id,
      document_type_id: @profile.document_type_id,
      user_id: @profile.user_id,
      created_at: @profile.created_at,
      updated_at: @profile.updated_at
    }
    render json: profile
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    if @profile.save
      @obj = {
        id: @profile.id,
        firt_name: @profile.firt_name,
        last_name: @profile.last_name,
        avatar: @profile.avatar.attached? ? url_for(@profile.avatar) : nil,
        phone: @profile.phone,
        birth_date: @profile.birth_date,
        document_id: @profile.document_id,
        document_type_id: @profile.document_type_id,
        user_id: @profile.user_id,
        created_at: @profile.created_at,
        updated_at: @profile.updated_at
      }
      render json: @obj, status: :created, location: @obj
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
    
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    if @profile.update(profile_params)
      @obj = {
        id: @profile.id,
        firt_name: @profile.firt_name,
        last_name: @profile.last_name,
        avatar: @profile.avatar.attached? ? url_for(@profile.avatar) : nil,
        phone: @profile.phone,
        birth_date: @profile.birth_date,
        document_id: @profile.document_id,
        document_type_id: @profile.document_type_id,
        user_id: @profile.user_id,
        created_at: @profile.created_at,
        updated_at: @profile.updated_at
      }
      render json: @obj, status: :created, location: @obj
    else
      render json: @profile.errors, status: :unprocessable_entity
    end    
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
  end

  private

    def set_user
      @user = User.all.first #User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:firt_name, :last_name, :avatar, :phone, :document_id, :document_type_id, :user_id, :birth_date)
    end
end
