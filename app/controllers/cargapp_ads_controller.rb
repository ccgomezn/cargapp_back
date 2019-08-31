class CargappAdsController < ApplicationController
  before_action :set_cargapp_ad, only: [:show, :edit, :update, :destroy]

  # GET /cargapp_ads
  # GET /cargapp_ads.json
  def index
    @cargapp_ads = CargappAd.all
  end

  # GET /cargapp_ads/1
  # GET /cargapp_ads/1.json
  def show
  end

  # GET /cargapp_ads/new
  def new
    @cargapp_ad = CargappAd.new
  end

  # GET /cargapp_ads/1/edit
  def edit
  end

  # POST /cargapp_ads
  # POST /cargapp_ads.json
  def create
    @cargapp_ad = CargappAd.new(cargapp_ad_params)

    respond_to do |format|
      if @cargapp_ad.save
        format.html { redirect_to @cargapp_ad, notice: 'Cargapp ad was successfully created.' }
        format.json { render :show, status: :created, location: @cargapp_ad }
      else
        format.html { render :new }
        format.json { render json: @cargapp_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cargapp_ads/1
  # PATCH/PUT /cargapp_ads/1.json
  def update
    respond_to do |format|
      if @cargapp_ad.update(cargapp_ad_params)
        format.html { redirect_to @cargapp_ad, notice: 'Cargapp ad was successfully updated.' }
        format.json { render :show, status: :ok, location: @cargapp_ad }
      else
        format.html { render :edit }
        format.json { render json: @cargapp_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cargapp_ads/1
  # DELETE /cargapp_ads/1.json
  def destroy
    @cargapp_ad.destroy
    respond_to do |format|
      format.html { redirect_to cargapp_ads_url, notice: 'Cargapp ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cargapp_ad
      @cargapp_ad = CargappAd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cargapp_ad_params
      params.require(:cargapp_ad).permit(:name, :price, :description, :body, :image, :url, :media, :have_discoun, :is_percentage, :discoun, :user_id, :active)
    end
end
