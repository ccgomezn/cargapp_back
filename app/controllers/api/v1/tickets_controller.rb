class Api::V1::TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user



  swagger_controller :tickets, 'Tickets Management'

  swagger_api :index do
    summary 'Fetches all Ticket items'
    notes 'This lists all the tickets'
  end

  swagger_api :active do
    summary 'Fetches all active Ticket items'
    notes 'This lists all the active tickets'
  end

  swagger_api :create do
    summary 'Creates a new Ticket'
    param :form, 'ticket[body]', :integer, :required, 'Body of ticket'
    param :form, 'ticket[image]', :file, :required, 'Image associated to ticket'
    param :form, 'ticket[media]', :file, :required, 'Media associated to ticket'
    param :form, 'ticket[status_id]', :integer, :required, 'Id of status'
    param :form, 'ticket[user_id]', :integer, :required, 'Id of user associated to ticket'
    param :form, 'ticket[active]', :boolean, :required, 'Activation state'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Ticket'
    param :path, :id, :integer, :required, "Ticket Id"
    param :form, 'ticket[body]', :integer, :optional, 'Body of ticket'
    param :form, 'ticket[image]', :file, :optional, 'Image associated to ticket'
    param :form, 'ticket[media]', :file, :optional, 'Media associated to ticket'
    param :form, 'ticket[status_id]', :integer, :optional, 'Id of status'
    param :form, 'ticket[user_id]', :integer, :optional, 'Id of user associated to ticket'
    param :form, 'ticket[active]', :boolean, :optional, 'Activation state'
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Ticket"
    param :path, :id, :integer, :optional, "Ticket Id"
    response :unauthorized
    response :not_found
  end

  swagger_api :show do
    summary "Shows a Ticket"
    param :path, :id, :integer, :optional, "Ticket Id"
    response :unauthorized
    response :not_found
  end

  swagger_api :me do
    summary "Shows mine existing Ticket"
    response :unauthorized
  end





  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all
    @result = []
    @tickets.each do |ticket|
      @obj = {
        id: ticket.id,
        title: ticket.title,
        body: ticket.body,
        statu_id: ticket.statu_id,
        user_id: ticket.user_id,
        active: ticket.active,
        image: ticket.image.attached? ? url_for(ticket.image) : nil,
        media: ticket.image.attached? ? url_for(ticket.image) : nil,
        created_at: ticket.created_at,
        updated_at: ticket.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  def me
    @tickets = @user.tickets #CargappIntegration.where(active: true, user_id: @user)
    @result = []
    @tickets.each do |ticket|
      @obj = {
        id: ticket.id,
        title: ticket.title,
        body: ticket.body,
        statu_id: ticket.statu_id,
        user_id: ticket.user_id,
        active: ticket.active,
        image: ticket.image.attached? ? url_for(ticket.image) : nil,
        media: ticket.image.attached? ? url_for(ticket.image) : nil,
        created_at: ticket.created_at,
        updated_at: ticket.updated_at
      }
      @result << @obj
    end
    render json: @result
  end


  def active
    @tickets = Ticket.where(active: true)
    @result = []
    @tickets.each do |ticket|
      @obj = {
        id: ticket.id,
        title: ticket.title,
        body: ticket.body,
        statu_id: ticket.statu_id,
        user_id: ticket.user_id,
        active: ticket.active,
        image: ticket.image.attached? ? url_for(ticket.image) : nil,
        media: ticket.image.attached? ? url_for(ticket.image) : nil,
        created_at: ticket.created_at,
        updated_at: ticket.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @obj = {
      id: @ticket.id,
      title: @ticket.title,
      body: @ticket.body,
      statu_id: @ticket.statu_id,
      user_id: @ticket.user_id,
      active: @ticket.active,
      image: @ticket.image.attached? ? url_for(@ticket.image) : nil,
      media: @ticket.image.attached? ? url_for(@ticket.image) : nil,
      created_at: @ticket.created_at,
      updated_at: @ticket.updated_at
    }
    render json: @obj
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      @obj = {
        id: @ticket.id,
        title: @ticket.title,
        body: @ticket.body,
        statu_id: @ticket.statu_id,
        user_id: @ticket.user_id,
        active: @ticket.active,
        image: @ticket.image.attached? ? url_for(@ticket.image) : nil,
        media: @ticket.image.attached? ? url_for(@ticket.image) : nil
      }
      render json: @obj, status: :created, location: @obj
      # 'ticket was successfully created.'
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    if @ticket.update(ticket_params)

      @obj = {
        id: @ticket.id,
        title: @ticket.title,
        body: @ticket.body,
        statu_id: @ticket.statu_id,
        user_id: @ticket.user_id,
        active: @ticket.active,
        image: @ticket.image.attached? ? url_for(@ticket.image) : nil,
        media: @ticket.media.attached? ? url_for(@ticket.media) : nil
      }

      render json: @obj
      # 'ticket was successfully updated.'
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
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
        role = Role.find_by(name: 'USER', active: true)
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
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:title, :body, :image, :media, :statu_id, :user_id, :active)
    end
end
