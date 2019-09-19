class Api::V1::ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user
  swagger_controller :reports, 'Reports'

  swagger_api :index do
    summary 'Fetches all Report items'
    notes 'This lists all the reports'
  end

  swagger_api :active do
    summary 'Fetches all active Report items'
    notes 'This lists all the active reports'
  end

  swagger_api :create do
    summary 'Creates a new Report'
    param :form, 'report[name]', :string, :required, 'Name'
    param :form, 'report[origin]', :string, :required, 'Origin'
    param :form, 'report[destination]', :string, :required, 'Destination'
    param :form, 'report[cause]', :string, :required, 'Cause'
    param :form, 'report[sense]', :date, :required, 'Sense'
    param :form, 'report[novelty]', :string, :required, 'Novelty'
    param :form, 'report[geolocation]', :string, :required, 'Geolocation'
    param :form, 'report[image]', :file, :required, 'Image'
    param :form, 'report[start_date]', :date, :required, 'Start date'
    param :form, 'report[end_date]', :date, :required, 'End date'
    param :form, 'report[report_type]', :string, :required, 'Report type related'
    param :form, 'report[user_id]', :integer, :required, 'Id of user related'
    param :form, 'report[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing User-Payment'
    param :path, :id, :integer, :required, 'Report Id'
    param :form, 'report[name]', :string, :optional, 'Name'
    param :form, 'report[origin]', :string, :optional, 'Origin'
    param :form, 'report[destination]', :string, :optional, 'Destination'
    param :form, 'report[cause]', :string, :optional, 'Cause'
    param :form, 'report[sense]', :date, :optional, 'Sense'
    param :form, 'report[novelty]', :string, :optional, 'Novelty'
    param :form, 'report[geolocation]', :string, :optional, 'Geolocation'
    param :form, 'report[image]', :file, :optional, 'Image'
    param :form, 'report[start_date]', :date, :optional, 'Start date'
    param :form, 'report[end_date]', :date, :optional, 'End date'
    param :form, 'report[report_type]', :string, :optional, 'Report type related'
    param :form, 'report[user_id]', :integer, :optional, 'Id of user related'
    param :form, 'report[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary 'Deletes an existing Report'
    param :path, :id, :integer, :optional, 'Report Id'
    response :unauthorized
    response :not_found
  end

  swagger_api :me do
    summary 'Shows mine Report'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Shows Report'
    param :path, :id, :integer, :optional, 'Report Id'
    response :unauthorized
    response :not_found
  end

  swagger_api :find_user do
    summary 'Shows reports of an specific user'
    param :path, :id, :integer, :optional, 'User Id'
    response :unauthorized
    response :not_found
  end

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

  def find_user
    user = User.find_by(id: params[:user][:id])
    @reports = user.reports
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
          response = { response: 'Does not have permissions' }
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
          response = { response: 'Does not have permissions' }
          render json: response, status: :unprocessable_entity
        end
      end
    end

    def if_super
      @if_super = (User.is_super?(@user) if @user) || false
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
