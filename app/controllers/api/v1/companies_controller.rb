class Api::V1::CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  #before_action :doorkeeper_authorize!
  #before_action :set_user

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

  swagger_api :show do
    summary 'Fetches detailed Company items'
    param :path, :id, :integer, :optional, "Company Id"
    notes 'This lists detailed companies'
  end

  swagger_api :me do
    summary 'Fetches mine Company items'
    notes 'This lists mine companies'
  end

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all

    @result = []
    @companies.each do |company|
      @obj = {
        id: company.id,
        name: company.name,
        identify: company.identify,
        image: company.image.attached? ? url_for(company.image) : nil,
        description: company.description,
        company_type: company.company_type,
        load_type_id: company.load_type_id,
        sector: company.sector,
        legal_representative: company.legal_representative,
        address: company.address,
        phone: company.phone,
        phone: company.phone,
        constitution_date: company.constitution_date,
        active: company.active,
        created_at: company.created_at,
        updated_at: company.updated_at
      }
      @result << @obj
    end
    render json: @result
  end
  
  def active
    @companies = Company.where(active: true)

    @result = []
    @companies.each do |company|
      @obj = {
        id: company.id,
        name: company.name,
        identify: company.identify,
        image: company.image.attached? ? url_for(company.image) : nil,
        description: company.description,
        company_type: company.company_type,
        load_type_id: company.load_type_id,
        sector: company.sector,
        legal_representative: company.legal_representative,
        address: company.address,
        phone: company.phone,
        phone: company.phone,
        constitution_date: company.constitution_date,
        active: company.active,
        created_at: company.created_at,
        updated_at: company.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  def me
    @companies = @user.companies #CargappIntegration.where(active: true, user_id: @user)

    @result = []
    @companies.each do |company|
      @obj = {
        id: company.id,
        name: company.name,
        identify: company.identify,
        image: company.image.attached? ? url_for(company.image) : nil,
        description: company.description,
        company_type: company.company_type,
        load_type_id: company.load_type_id,
        sector: company.sector,
        legal_representative: company.legal_representative,
        address: company.address,
        phone: company.phone,
        phone: company.phone,
        constitution_date: company.constitution_date,
        active: company.active,
        created_at: company.created_at,
        updated_at: company.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  def find_users
    @company = Company.find_by(id: params[:id])
    users = []
    @company.company_users.each do |company|
      user_obj = {
        user: company.user,
        company_users: {  id: @company.id,
          name: @company.name,
          identify: @company.identify,
          image: @company.image.attached? ? url_for(@company.image) : nil,
          description: @company.description,
          company_type: @company.company_type,
          load_type_id: @company.load_type_id,
          sector: @company.sector,
          legal_representative: @company.legal_representative,
          address: @company.address,
          phone: @company.phone,
          phone: @company.phone,
          constitution_date: @company.constitution_date,
          active: @company.active,
          created_at: @company.created_at,
          updated_at: @company.updated_at
        }
      }
      users << user_obj || @company.user
    end 
    render json: users
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    company = {  id: @company.id,
      name: @company.name,
      identify: @company.identify,
      image: @company.image.attached? ? url_for(@company.image) : nil,
      description: @company.description,
      company_type: @company.company_type,
      load_type_id: @company.load_type_id,
      sector: @company.sector,
      legal_representative: @company.legal_representative,
      address: @company.address,
      phone: @company.phone,
      phone: @company.phone,
      constitution_date: @company.constitution_date,
      active: @company.active,
      created_at: @company.created_at,
      updated_at: @company.updated_at
    }
    render json: company
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    if @company.save
      @obj = {  id: @company.id,
        name: @company.name,
        identify: @company.identify,
        image: @company.image.attached? ? url_for(@company.image) : nil,
        description: @company.description,
        company_type: @company.company_type,
        load_type_id: @company.load_type_id,
        sector: @company.sector,
        legal_representative: @company.legal_representative,
        address: @company.address,
        phone: @company.phone,
        phone: @company.phone,
        constitution_date: @company.constitution_date,
        active: @company.active,
        created_at: @company.created_at,
        updated_at: @company.updated_at
      }
      render json: @obj, status: :created, location: @obj
      # 'company was successfully created.'
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    if @company.update(company_params)
      @obj = {  id: @company.id,
        name: @company.name,
        identify: @company.identify,
        image: @company.image.attached? ? url_for(@company.image) : nil,
        description: @company.description,
        company_type: @company.company_type,
        load_type_id: @company.load_type_id,
        sector: @company.sector,
        legal_representative: @company.legal_representative,
        address: @company.address,
        phone: @company.phone,
        phone: @company.phone,
        constitution_date: @company.constitution_date,
        active: @company.active,
        created_at: @company.created_at,
        updated_at: @company.updated_at
      }

      render json: @obj
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
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :description, :company_type, :load_type_id, :sector, :legal_representative, :address, :phone, :user_id, :constitution_date, :active, :image, :identify)
    end
end
