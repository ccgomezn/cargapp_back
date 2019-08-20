class Api::V1::ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
    @result = []
    @reports.each do |report|
      @obj = {
        id: report.id,
        name: report.name,
        origin: report.origin,
        destination: report.destination,
        report_type: report.report_type,
        cause: report.cause,
        sense: report.sense,
        novelty: report.novelty,
        geolocation: report.geolocation,
        image: report.image.attached? ? url_for(report.image) : nil,
        start_date: report.start_date,
        end_date: report.end_date,
        active: report.active,        
        user_id: report.user_id,
        created_at: report.created_at,
        updated_at: report.updated_at
      }
      @result << @obj
    end
    render json: @result
  end  

  def active
    @reports = Report.where(active: true)
    @result = []
    @reports.each do |report|
      @obj = {
        id: report.id,
        name: report.name,
        origin: report.origin,
        destination: report.destination,
        report_type: report.report_type,
        cause: report.cause,
        sense: report.sense,
        novelty: report.novelty,
        geolocation: report.geolocation,
        image: report.image.attached? ? url_for(report.image) : nil,
        start_date: report.start_date,
        end_date: report.end_date,
        active: report.active,        
        user_id: report.user_id,
        created_at: report.created_at,
        updated_at: report.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  def me
    @reports = @user.reports
    @result = []
    @reports.each do |report|
      @obj = {
        id: report.id,
        name: report.name,
        origin: report.origin,
        destination: report.destination,
        report_type: report.report_type,
        cause: report.cause,
        sense: report.sense,
        novelty: report.novelty,
        geolocation: report.geolocation,
        image: report.image.attached? ? url_for(report.image) : nil,
        start_date: report.start_date,
        end_date: report.end_date,
        active: report.active,        
        user_id: report.user_id,
        created_at: report.created_at,
        updated_at: report.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @obj = {
      id: @report.id,
      name: @report.name,
      origin: @report.origin,
      destination: @report.destination,
      report_type: @report.report_type,
      cause: @report.cause,
      sense: @report.sense,
      novelty: @report.novelty,
      geolocation: @report.geolocation,
      image: @report.image.attached? ? url_for(@report.image) : nil,
      start_date: @report.start_date,
      end_date: @report.end_date,
      active: @report.active,        
      user_id: @report.user_id,
      created_at: @report.created_at,
      updated_at: @report.updated_at
    }

    render json: @obj
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    if @report.save
      @obj = {
        id: @report.id,
        name: @report.name,
        origin: @report.origin,
        destination: @report.destination,
        report_type: @report.report_type,
        cause: @report.cause,
        sense: @report.sense,
        novelty: @report.novelty,
        geolocation: @report.geolocation,
        image: @report.image.attached? ? url_for(@report.image) : nil,
        start_date: @report.start_date,
        end_date: @report.end_date,
        active: @report.active,        
        user_id: @report.user_id,
        created_at: @report.created_at,
        updated_at: @report.updated_at
      }
      render json: @obj, status: :created, location: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    if @report.update(report_params)
      @obj = {
        id: @report.id,
        name: @report.name,
        origin: @report.origin,
        destination: @report.destination,
        report_type: @report.report_type,
        cause: @report.cause,
        sense: @report.sense,
        novelty: @report.novelty,
        geolocation: @report.geolocation,
        image: @report.image.attached? ? url_for(@report.image) : nil,
        start_date: @report.start_date,
        end_date: @report.end_date,
        active: @report.active,        
        user_id: @report.user_id,
        created_at: @report.created_at,
        updated_at: @report.updated_at
      }
      render json: @obj, status: :ok, location: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:name, :origin, :destination, :cause, :sense, :novelty, :geolocation, :image, :start_date, :end_date, :report_type, :user_id, :active)
    end
end
