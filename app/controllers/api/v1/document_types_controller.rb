class Api::V1::DocumentTypesController < ApplicationController
  before_action :set_document_type, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!

  swagger_controller :loadTypes, 'Document Types Management'

  swagger_api :index do
    summary 'Fetches all Document Types items'
    notes 'This lists all the document types'
  end

  swagger_api :active do
    summary 'Fetches all active Document Types items'
    notes 'This lists all the active document types'
  end

  swagger_api :create do
    summary 'Creates a new Document Type'
    param :form, 'document_type[name]', :string, :required, 'Name'
    param :form, 'document_type[code]', :string, :required, 'Code'
    param :form, 'document_type[description]', :string, :required, 'Description'
    param :form, 'document_type[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Document Type'
    param :path, :id, :integer, :required, "Document Type Id"
    param :form, 'document_type[name]', :string, :optional, 'Name'
    param :form, 'document_type[code]', :string, :optional, 'Code'
    param :form, 'document_type[description]', :string, :optional, 'Description'
    param :form, 'document_type[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Document Type"
    param :path, :id, :integer, :optional, "Document Type Id"
    response :unauthorized
    response :not_found
  end
  # GET /document_types
  # GET /document_types.json
  def index
    @document_types = DocumentType.all

    render json: @document_types
  end

  def active
    @document_types = DocumentType.where(active: true)

    render json: @document_types
  end

  # GET /document_types/1
  # GET /document_types/1.json
  def show
    render json: @document_type
  end

  # POST /document_types
  # POST /document_types.json
  def create
    @document_type = DocumentType.new(document_type_params)

    if @document_type.save
      render json: @document_type, status: :created, location: @document_type
      # 'document_type was successfully created.'
    else
      render json: @document_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /document_types/1
  # PATCH/PUT /document_types/1.json
  def update
    if @document_type.update(document_type_params)
      render json: @document_type
      # 'document_type was successfully updated.'
    else
      render json: @document_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /document_types/1
  # DELETE /document_types/1.json
  def destroy
    @document_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_type
      @document_type = DocumentType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_type_params
      params.require(:document_type).permit(:name, :code, :description, :active)
    end
end
