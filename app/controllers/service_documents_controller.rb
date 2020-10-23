class ServiceDocumentsController < ApplicationController
  before_action :set_service_document, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /service_documents
  # GET /service_documents.json
  def index
    @service_documents = ServiceDocument.all
  end

  # GET /service_documents/1
  # GET /service_documents/1.json
  def show
  end

  # GET /service_documents/new
  def new
    @service_document = ServiceDocument.new
  end

  # GET /service_documents/1/edit
  def edit
  end

  # POST /service_documents
  # POST /service_documents.json
  def create
    @service_document = ServiceDocument.new(service_document_params)

    respond_to do |format|
      if @service_document.save
        format.html { redirect_to @service_document, notice: 'Service document was successfully created.' }
        format.json { render :show, status: :created, location: @service_document }
      else
        format.html { render :new }
        format.json { render json: @service_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /service_documents/1
  # PATCH/PUT /service_documents/1.json
  def update
    respond_to do |format|
      if @service_document.update(service_document_params)
        format.html { redirect_to @service_document, notice: 'Service document was successfully updated.' }
        format.json { render :show, status: :ok, location: @service_document }
      else
        format.html { render :edit }
        format.json { render json: @service_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_documents/1
  # DELETE /service_documents/1.json
  def destroy
    @service_document.destroy
    respond_to do |format|
      format.html { redirect_to service_documents_url, notice: 'Service document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_document
      @service_document = ServiceDocument.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_document_params
      params.require(:service_document).permit(:name, :document_type, :document, :service_id, :user_id, :active)
    end
end
