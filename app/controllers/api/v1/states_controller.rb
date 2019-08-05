class Api::V1::StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary

  # GET /states
  # GET /states.json
  def index
    @states = State.all
        
    render json: @states
  end

  def active
    @states = State.where(active: true)

    render json: @states
  end

  # GET /states/1
  # GET /states/1.json
  def show
    render json: @state
  end

  # POST /states
  # POST /states.json
  def create
    @state = State.new(state_params)

    if @state.save
      render json: @state, status: :created, location: @state
      # 'state was successfully created.'
    else
      render json: @state.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /states/1
  # PATCH/PUT /states/1.json
  def update
    if @state.update(state_params)
      render json: @state
      # 'State was successfully updated.'
    else
      render json: @state.errors, status: :unprocessable_entity
    end
  end

  # DELETE /states/1
  # DELETE /states/1.json
  def destroy
    @state.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def state_params
      params.require(:state).permit(:name, :code, :description, :country_id, :active)
    end
end
