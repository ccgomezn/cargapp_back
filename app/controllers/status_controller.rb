class StatusController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /status
  # GET /status.json
  def index
    @status = Statu.all
  end

  # GET /status/1
  # GET /status/1.json
  def show
  end

  # GET /status/new
  def new
    @status = Statu.new
  end

  # GET /status/1/edit
  def edit
  end

  # POST /status
  # POST /status.json
  def create
    @status = Statu.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to @status, notice: 'Statu was successfully created.' }
        format.json { render :show, status: :created, location: @status }
      else
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /status/1
  # PATCH/PUT /status/1.json
  def update
    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to @status, notice: 'Statu was successfully updated.' }
        format.json { render :show, status: :ok, location: @status }
      else
        format.html { render :edit }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /status/1
  # DELETE /status/1.json
  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to status_url, notice: 'Statu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Statu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:name, :code, :description, :user_id, :cargapp_model_id, :active)
    end
end
