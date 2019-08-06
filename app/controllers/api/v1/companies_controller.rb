class class Api::V1::CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary

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
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :description, :company_type, :load_type_id, :sector, :legal_representative, :address, :phone, :user_id, :constitution_date, :active)
    end
end
