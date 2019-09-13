class Api::V1::CargappAdsController < ApplicationController
  before_action :set_cargapp_ad, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user



  swagger_controller :cargappAds, 'Cargapp Ads Management'

  swagger_api :index do
    summary 'Fetches all Cargapp Ads items'
    notes 'This lists all the cargapp ads'
  end

  swagger_api :active do
    summary 'Fetches all active Cargapp Ads items'
    notes 'This lists all the active cargapp ads'
  end

  swagger_api :create do
    summary 'Creates a new Bank Account'
    param :form, "cargapp_ad[name]", :string, :required, 'Name'
    param :form, "cargapp_ad[price]", :string, :required, 'Price'
    param :form, "cargapp_ad[price]", :string, :required, 'Description'
    param :form, "cargapp_ad[body]", :string, :required, 'Body'
    param :form, "cargapp_ad[image]", :file, :required, 'Image'
    param :form, "cargapp_ad[url]", :string, :required, 'Url'
    param :form, "cargapp_ad[media]", :file, :required, 'Media'
    param :form, "cargapp_ad[have_discoun]", :boolean, :required, 'Have discount'
    param :form, "cargapp_ad[is_percentage]", :string, :required, 'Is percentage'
    param :form, "cargapp_ad[discoun]", :string, :required, 'Discount'
    param :form, "cargapp_ad[user_id]", :integer, :required, 'Id of user related'
    param :form, "cargapp_ad[active]", :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Cargapp Ad'
    param :path, :id, :integer, :required, "Cargapp Ad Id"
    param :form, "cargapp_ad[name]", :string, :optional, 'Name'
    param :form, "cargapp_ad[price]", :string, :optional, 'Price'
    param :form, "cargapp_ad[price]", :string, :optional, 'Description'
    param :form, "cargapp_ad[body]", :string, :optional, 'Body'
    param :form, "cargapp_ad[image]", :file, :optional, 'Image'
    param :form, "cargapp_ad[url]", :string, :optional, 'Url'
    param :form, "cargapp_ad[media]", :file, :optional, 'Media'
    param :form, "cargapp_ad[have_discoun]", :boolean, :optional, 'Have discount'
    param :form, "cargapp_ad[is_percentage]", :string, :optional, 'Is percentage'
    param :form, "cargapp_ad[discoun]", :string, :optional, 'Discount'
    param :form, "cargapp_ad[user_id]", :integer, :optional, 'Id of user related'
    param :form, "cargapp_ad[active]", :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Cargapp Ad"
    param :path, :id, :integer, :optional, "Cargapp Ad Id"
    response :unauthorized
    response :not_found
  end


  # GET /cargapp_ads
  # GET /cargapp_ads.json
  def index
    @cargapp_ads = CargappAd.all

    @result = []
    @cargapp_ads.each do |cargapp_ad|
      @obj = {
        id: cargapp_ad.id,
        name: cargapp_ad.name,
        price: cargapp_ad.price,
        description: cargapp_ad.description,
        body: cargapp_ad.body,
        image: cargapp_ad.image.attached? ? url_for(cargapp_ad.image) : nil,
        url: cargapp_ad.url,
        media: cargapp_ad.media.attached? ? url_for(cargapp_ad.media) : nil,
        have_discoun: cargapp_ad.have_discoun,
        is_percentage: cargapp_ad.is_percentage,
        discoun: cargapp_ad.discoun,
        user_id: cargapp_ad.user_id,
        created_at: cargapp_ad.created_at,
        updated_at: cargapp_ad.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  def active
    @cargapp_ads = CargappAd.where(active: true)

    @result = []
    @cargapp_ads.each do |cargapp_ad|
      @obj = {
        id: cargapp_ad.id,
        name: cargapp_ad.name,
        price: cargapp_ad.price,
        description: cargapp_ad.description,
        body: cargapp_ad.body,
        image: cargapp_ad.image.attached? ? url_for(cargapp_ad.image) : nil,
        url: cargapp_ad.url,
        media: cargapp_ad.media.attached? ? url_for(cargapp_ad.media) : nil,
        have_discoun: cargapp_ad.have_discoun,
        is_percentage: cargapp_ad.is_percentage,
        discoun: cargapp_ad.discoun,
        user_id: cargapp_ad.user_id,
        created_at: cargapp_ad.created_at,
        updated_at: cargapp_ad.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  def me
    @cargapp_ads = @user.cargapp_ads

    @result = []
    @cargapp_ads.each do |cargapp_ad|
      @obj = {
        id: cargapp_ad.id,
        name: cargapp_ad.name,
        price: cargapp_ad.price,
        description: cargapp_ad.description,
        body: cargapp_ad.body,
        image: cargapp_ad.image.attached? ? url_for(cargapp_ad.image) : nil,
        url: cargapp_ad.url,
        media: cargapp_ad.media.attached? ? url_for(cargapp_ad.media) : nil,
        have_discoun: cargapp_ad.have_discoun,
        is_percentage: cargapp_ad.is_percentage,
        discoun: cargapp_ad.discoun,
        user_id: cargapp_ad.user_id,
        created_at: cargapp_ad.created_at,
        updated_at: cargapp_ad.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  # GET /cargapp_ads/1
  # GET /cargapp_ads/1.json
  def show
    @obj = {
      id: @cargapp_ad.id,
      name: @cargapp_ad.name,
      price: @cargapp_ad.price,
      description: @cargapp_ad.description,
      body: @cargapp_ad.body,
      image: @cargapp_ad.image.attached? ? url_for(@cargapp_ad.image) : nil,
      url: @cargapp_ad.url,
      media: @cargapp_ad.media.attached? ? url_for(@cargapp_ad.media) : nil,
      have_discoun: @cargapp_ad.have_discoun,
      is_percentage: @cargapp_ad.is_percentage,
      discoun: @cargapp_ad.discoun,
      user_id: @cargapp_ad.user_id,
      created_at: @cargapp_ad.created_at,
      updated_at: @cargapp_ad.updated_at
    }    
    render json: @obj
  end


  # POST /cargapp_ads
  # POST /cargapp_ads.json
  def create
    @cargapp_ad = CargappAd.new(cargapp_ad_params)

    if @cargapp_ad.save
      @obj = {
        id: @cargapp_ad.id,
        name: @cargapp_ad.name,
        price: @cargapp_ad.price,
        description: @cargapp_ad.description,
        body: @cargapp_ad.body,
        image: @cargapp_ad.image.attached? ? url_for(@cargapp_ad.image) : nil,
        url: @cargapp_ad.url,
        media: @cargapp_ad.media.attached? ? url_for(@cargapp_ad.media) : nil,
        have_discoun: @cargapp_ad.have_discoun,
        is_percentage: @cargapp_ad.is_percentage,
        discoun: @cargapp_ad.discoun,
        user_id: @cargapp_ad.user_id,
        created_at: @cargapp_ad.created_at,
        updated_at: @cargapp_ad.updated_at
      }
      render json: @obj, status: :created, location: @cargapp_ad
    else
      render json: @cargapp_ad.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cargapp_ads/1
  # PATCH/PUT /cargapp_ads/1.json
  def update
      if @cargapp_ad.update(cargapp_ad_params)
        @obj = {
          id: @cargapp_ad.id,
          name: @cargapp_ad.name,
          price: @cargapp_ad.price,
          description: @cargapp_ad.description,
          body: @cargapp_ad.body,
          image: @cargapp_ad.image.attached? ? url_for(@cargapp_ad.image) : nil,
          url: @cargapp_ad.url,
          media: @cargapp_ad.media.attached? ? url_for(@cargapp_ad.media) : nil,
          have_discoun: @cargapp_ad.have_discoun,
          is_percentage: @cargapp_ad.is_percentage,
          discoun: @cargapp_ad.discoun,
          user_id: @cargapp_ad.user_id,
          created_at: @cargapp_ad.created_at,
          updated_at: @cargapp_ad.updated_at
        }
        render json: @obj, status: :ok, location: @cargapp_ad
      else
        render json: @cargapp_ad.errors, status: :unprocessable_entity
      end
  end

  # DELETE /cargapp_ads/1
  # DELETE /cargapp_ads/1.json
  def destroy
    @cargapp_ad.destroy    
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
    def set_cargapp_ad
      @cargapp_ad = CargappAd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cargapp_ad_params
      params.require(:cargapp_ad).permit(:name, :price, :description, :body, :image, :url, :media, :have_discoun, :is_percentage, :discoun, :user_id, :active)
    end
end
