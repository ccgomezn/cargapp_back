class VehicleDocumentsController < ApplicationController
  before_action :set_vehicle_document, only: [:show, :edit, :update, :destroy]

  # GET /vehicle_documents
  # GET /vehicle_documents.json
  def index
    @vehicle_documents = VehicleDocument.all
  end

  # GET /vehicle_documents/1
  # GET /vehicle_documents/1.json
  def show
  end

  # GET /vehicle_documents/new
  def new
    @vehicle_document = VehicleDocument.new
  end

  # GET /vehicle_documents/1/edit
  def edit
  end

  # POST /vehicle_documents
  # POST /vehicle_documents.json
  def create
    @vehicle_document = VehicleDocument.new(vehicle_document_params)

    respond_to do |format|
      if @vehicle_document.save
        format.html { redirect_to @vehicle_document, notice: 'Vehicle document was successfully created.' }
        format.json { render :show, status: :created, location: @vehicle_document }
      else
        format.html { render :new }
        format.json { render json: @vehicle_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicle_documents/1
  # PATCH/PUT /vehicle_documents/1.json
  def update
    respond_to do |format|
      if @vehicle_document.update(vehicle_document_params)
        format.html { redirect_to @vehicle_document, notice: 'Vehicle document was successfully updated.' }
        format.json { render :show, status: :ok, location: @vehicle_document }
      else
        format.html { render :edit }
        format.json { render json: @vehicle_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicle_documents/1
  # DELETE /vehicle_documents/1.json
  def destroy
    @vehicle_document.destroy
    respond_to do |format|
      format.html { redirect_to vehicle_documents_url, notice: 'Vehicle document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle_document
      @vehicle_document = VehicleDocument.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehicle_document_params
      params.require(:vehicle_document).permit(:document_type_id, :file, :statu_id, :user_id, :vehicle_id, :expire_date, :approved, :active)
    end
end
