class Api::V1::TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

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
        media: @ticket.image.attached? ? url_for(@ticket.image) : nil
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
      @user = User.all.first #User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
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
