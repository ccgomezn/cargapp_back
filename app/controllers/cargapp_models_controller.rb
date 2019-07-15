class CargappModelsController < ApplicationController
  before_action :set_cargapp_model, only: [:show, :edit, :update, :destroy]

  # GET /cargapp_models
  # GET /cargapp_models.json
  def index
    @cargapp_models = CargappModel.all
  end

  # GET /cargapp_models/1
  # GET /cargapp_models/1.json
  def show
  end

  # GET /cargapp_models/new
  def new
    @cargapp_model = CargappModel.new
  end

  # GET /cargapp_models/1/edit
  def edit
  end

  # POST /cargapp_models
  # POST /cargapp_models.json
  def create
    @cargapp_model = CargappModel.new(cargapp_model_params)

    respond_to do |format|
      if @cargapp_model.save
        format.html { redirect_to @cargapp_model, notice: 'Cargapp model was successfully created.' }
        format.json { render :show, status: :created, location: @cargapp_model }
      else
        format.html { render :new }
        format.json { render json: @cargapp_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cargapp_models/1
  # PATCH/PUT /cargapp_models/1.json
  def update
    respond_to do |format|
      if @cargapp_model.update(cargapp_model_params)
        format.html { redirect_to @cargapp_model, notice: 'Cargapp model was successfully updated.' }
        format.json { render :show, status: :ok, location: @cargapp_model }
      else
        format.html { render :edit }
        format.json { render json: @cargapp_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cargapp_models/1
  # DELETE /cargapp_models/1.json
  def destroy
    @cargapp_model.destroy
    respond_to do |format|
      format.html { redirect_to cargapp_models_url, notice: 'Cargapp model was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cargapp_model
      @cargapp_model = CargappModel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cargapp_model_params
      params.require(:cargapp_model).permit(:name, :code, :value, :description, :active)
    end
end
