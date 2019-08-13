class Api::V1::CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

  swagger_controller :companies, 'Companies Management'

  swagger_api :index do
    summary 'Fetches all Company items'
    notes 'This lists all the companies'
  end

  swagger_api :active do
    summary 'Fetches all active Company items'
    notes 'This lists all the active companies'
  end

  swagger_api :create do
    summary 'Creates a new Company'
    param :form, 'company[name]', :string, :required, 'Name'
    param :form, 'company[code]', :string, :required, 'Code'
    param :form, 'company[company_type]', :string, :required, 'Company Type'
    param :form, 'company[load_type_id]', :integer, :required, 'Load Type related to Id'
    param :form, 'company[sector]', :string, :required, 'Sector'
    param :form, 'company[legal_representative]', :string, :required, 'Legal representative of the Company'
    param :form, 'company[address]', :string, :required, 'Address'
    param :form, 'company[phone]', :string, :required, 'Phone'
    param :form, 'company[user_id]', :integer, :required, 'Id of user related to Company'
    param :form, 'company[constution_date]', :string, :required, 'Date of constitution of the company'
    param :form, 'company[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Company'
    param :path, :id, :integer, :required, "Company Id"
    param :form, 'company[name]', :string, :optional, 'Name'
    param :form, 'company[code]', :string, :optional, 'Code'
    param :form, 'company[company_type]', :string, :optional, 'Company Type'
    param :form, 'company[load_type_id]', :integer, :optional, 'Load Type related to Id'
    param :form, 'company[sector]', :string, :optional, 'Sector'
    param :form, 'company[legal_representative]', :string, :optional, 'Legal representative of the Company'
    param :form, 'company[address]', :string, :optional, 'Address'
    param :form, 'company[phone]', :string, :optional, 'Phone'
    param :form, 'company[user_id]', :integer, :optional, 'Id of user related to Company'
    param :form, 'company[constution_date]', :string, :optional, 'Date of constitution of the company'
    param :form, 'company[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Company"
    param :path, :id, :integer, :optional, "Company Id"
    response :unauthorized
    response :not_found
  end

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all

    render json: @companies
  end
  
  def active
    @companies = Company.where(ative: true)

    render json: @companies
  end

  def me
    @companies = @user.companies #CargappIntegration.where(active: true, user_id: @user)

    render json: @companies
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    render json: @company
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    if @company.save
      render json: @company, status: :created, location: @company
      # 'company was successfully created.'
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    if @company.update(company_params)
      render json: @company
      # 'company was successfully updated.'
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
  end

  private

    def set_user
      @user = User.all.first #User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :description, :company_type, :load_type_id, :sector, :legal_representative, :address, :phone, :user_id, :constitution_date, :active)
    end
end
