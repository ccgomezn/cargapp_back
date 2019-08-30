class Api::V1::ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user


  swagger_controller :profiles, 'Profiles Management'

  swagger_api :index do
    summary 'Fetches all Profile items'
    notes 'This lists all the profiles'
  end

  swagger_api :active do
    summary 'Fetches all active Profile items'
    notes 'This lists all the active profiles'
  end

  swagger_api :create do
    summary 'Creates a new Profile'
    param :form, 'profile[firt_name]', :string, :required, 'First name'
    param :form, 'profile[last_name]', :integer, :required, 'Last name'
    param :form, 'profile[avatar]', :string, :required, 'Profiles avatar'
    param :form, 'profile[phone]', :string, :required, 'Users phone'
    param :form, 'profile[document_id]', :string, :required, 'Id of document on profile'
    param :form, 'profile[document_type_id]', :integer, :required, 'Document type'
    param :form, 'profile[birth_date]', :string, :required, 'Birthday'
    param :form, 'profile[user_id]', :integer, :required, 'User associated to profile'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Profile'
    param :path, :id, :integer, :required, "Profile Id"
    param :form, 'profile[firt_name]', :string, :optional, 'First name'
    param :form, 'profile[last_name]', :integer, :optional, 'Last name'
    param :form, 'profile[avatar]', :string, :optional, 'Profiles avatar'
    param :form, 'profile[phone]', :string, :optional, 'Users phone'
    param :form, 'profile[document_id]', :string, :optional, 'Id of document on profile'
    param :form, 'profile[document_type_id]', :integer, :optional, 'Document type'
    param :form, 'profile[birth_date]', :string, :optional, 'Birthday'
    param :form, 'profile[user_id]', :integer, :optional, 'User associated to profile'
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Profile"
    param :path, :id, :integer, :optional, "Profile Id"
    response :unauthorized
    response :not_found
  end


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
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:firt_name, :last_name, :avatar, :phone, :document_id, :document_type_id, :user_id, :birth_date)
    end
end
