class LoadTypesController < ApplicationController
  before_action :set_load_type, only: [:show, :edit, :update, :destroy]

  # GET /load_types
  # GET /load_types.json
  def index
    @load_types = LoadType.all
  end

  # GET /load_types/1
  # GET /load_types/1.json
  def show
  end

  # GET /load_types/new
  def new
    @load_type = LoadType.new
  end

  # GET /load_types/1/edit
  def edit
  end

  # POST /load_types
  # POST /load_types.json
  def create
    @load_type = LoadType.new(load_type_params)

    respond_to do |format|
      if @load_type.save
        format.html { redirect_to @load_type, notice: 'Load type was successfully created.' }
        format.json { render :show, status: :created, location: @load_type }
      else
        format.html { render :new }
        format.json { render json: @load_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /load_types/1
  # PATCH/PUT /load_types/1.json
  def update
    respond_to do |format|
      if @load_type.update(load_type_params)
        format.html { redirect_to @load_type, notice: 'Load type was successfully updated.' }
        format.json { render :show, status: :ok, location: @load_type }
      else
        format.html { render :edit }
        format.json { render json: @load_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /load_types/1
  # DELETE /load_types/1.json
  def destroy
    @load_type.destroy
    respond_to do |format|
      format.html { redirect_to load_types_url, notice: 'Load type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_load_type
      @load_type = LoadType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def load_type_params
      params.require(:load_type).permit(:name, :code, :icon, :description, :active)
    end
end
