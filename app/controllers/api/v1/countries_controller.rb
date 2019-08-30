class Api::V1::CountriesController < ApplicationController
  before_action :set_country, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  swagger_controller :countries, 'Countries Management'

  swagger_api :index do
    summary 'Fetches all Country items'
    notes 'This lists all the countries'
  end

  swagger_api :active do
    summary 'Fetches all active Country items'
    notes 'This lists all the active countries'
  end

  swagger_api :create do
    summary 'Creates a new Country'
    param :form, 'country[name]', :string, :required, 'Name'
    param :form, 'country[code]', :string, :required, 'Code'
    param :form, 'country[description]', :string, :required, 'Description'
    param :form, 'country[cioc]', :string, :required, 'Cioc'
    param :form, 'country[currency_code]', :string, :required, 'Currency Code'
    param :form, 'country[currency_name]', :string, :required, 'Currency Name'
    param :form, 'country[currency_symbol]', :string, :required, 'Currency Symbol'
    param :form, 'country[language_iso639]', :string, :required, 'Language on iso639'
    param :form, 'country[language_name]', :string, :required, 'Language Name'
    param :form, 'country[language_native_name]', :string, :required, 'Language on Native Name'
    param :form, 'country[image]', :file, :required, 'Image Of Flag'
    param :form, 'country[date_utc]', :string, :required, 'Date UTC'
    param :form, 'country[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Country'
    param :path, :id, :integer, :required, "Country Id"
    param :form, 'country[name]', :string, :optional, 'Name'
    param :form, 'country[code]', :string, :optional, 'Code'
    param :form, 'country[description]', :string, :optional, 'Description'
    param :form, 'country[cioc]', :string, :optional, 'Cioc'
    param :form, 'country[currency_code]', :string, :optional, 'Currency Code'
    param :form, 'country[currency_name]', :string, :optional, 'Currency Name'
    param :form, 'country[currency_symbol]', :string, :optional, 'Currency Symbol'
    param :form, 'country[language_iso639]', :string, :optional, 'Language on iso639'
    param :form, 'country[language_name]', :string, :optional, 'Language Name'
    param :form, 'country[language_native_name]', :string, :optional, 'Language on Native Name'
    param :form, 'country[image]', :file, :optional, 'Image Of Flag'
    param :form, 'country[date_utc]', :string, :optional, 'Date UTC'
    param :form, 'country[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Country"
    param :path, :id, :integer, :optional, "Country Id"
    response :unauthorized
    response :not_found
  end

  # GET /countries
  # GET /countries.json
  def index
    @countries = Country.all
    
    render json: @countries
  end

  def active
    @countries = Country.where(active: true)

    render json: @countries
  end

  def migration
    source = 'https://restcountries.eu/rest/v2/all'
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    result = JSON.parse(data)
    countries = []
    result.each do |country|
      countries << Country.find_or_create_by(name: country['name'],
                                             code: country['callingCodes'][0], cioc: country['cioc'],
                                             image: %(https://restcountries.eu/data/#{country['cioc'].to_s.downcase}.svg),
                                             currency_code: country['currencies'][0]['code'],
                                             currency_name: country['currencies'][0]['name'],
                                             currency_symbol: country['currencies'][0]['symbol'],
                                             active: false,
                                             # latitude: country['latlng'][0].to_s, longitude: country['latlng'][1].to_s,
                                             language_iso639: country['languages'][0]['iso639_1'], language_name: country['languages'][0]['name'],
                                             language_native_name: country['languages'][0]['nativeName'])
    end
    render json: countries.as_json(only: %i[id name code cioc image currency_symbol language_iso639 language_native_name])
    # redirect_back(fallback_location: dasboard_path, notice: 'Countries Migrated.')      
  end

  # GET /countries/1
  # GET /countries/1.json
  def show
    render json: @country
  end 

  # POST /countries
  # POST /countries.json
  def create
    @country = Country.new(country_params)

    if @country.save
      render json: @country, status: :created, location: @country
      # 'Country was successfully created.'
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /countries/1
  # PATCH/PUT /countries/1.json
  def update
    if @country.update(country_params)
      render json: @country
      # 'Country model was successfully updated.'
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  # DELETE /countries/1
  # DELETE /countries/1.json
  def destroy
    @country.destroy
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
    def set_country
      @country = Country.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def country_params
      params.require(:country).permit(:name, :code, :description, :cioc, :currency_code, :currency_name, :currency_symbol, :language_iso639, :language_name, :language_native_name, :image, :date_utc, :active)
    end
end
