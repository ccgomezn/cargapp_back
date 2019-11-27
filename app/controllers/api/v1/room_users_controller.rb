class Api::V1::RoomUsersController < ApplicationController
  before_action :set_room_user, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  # GET /room_users
  # GET /room_users.json
  def index
    @room_users = RoomUser.all
    render json: @room_users
  end

  def active
    @room_users = RoomUser.where(active: true)
    render json: @room_users
  end

  def me
    @room_users = @user.room_users
    render json: @room_users
  end

  def users_service
    @room_users = RoomUser.where(service_id: params[:id])
    render json: @room_users
  end

  def users_room
    @room_users = RoomUser.where(room_id: params[:id])
    render json: @room_users
  end

  def check
    @room_users = RoomUser.find_by(room_id: params[:id], user_id: @user.id)
    if @room_users
      render json: true
    else
      render json: false
    end
  end

  # GET /room_users/1
  # GET /room_users/1.json
  def show
    render json: @room_user
  end

  # POST /room_users
  # POST /room_users.json
  def create
    @room_user = RoomUser.new(room_user_params)
      if @room_user.save
        render json: @room_user, status: :created, location: @room_user
      else
        render json: @room_user.errors, status: :unprocessable_entity    
    end
  end

  # PATCH/PUT /room_users/1
  # PATCH/PUT /room_users/1.json
  def update
    respond_to do |format|
      if @room_user.update(room_user_params)
        format.html { redirect_to @room_user, notice: 'Room user was successfully updated.' }
        format.json { render :show, status: :ok, location: @room_user }
      else
        format.html { render :edit }
        format.json { render json: @room_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /room_users/1
  # DELETE /room_users/1.json
  def destroy
    @room_user.destroy
    respond_to do |format|
      format.html { redirect_to room_users_url, notice: 'Room user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_user
      @room_user = RoomUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_user_params
      params.require(:room_user).permit(:service_id, :room_id, :user_id, :active)
    end

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
end
