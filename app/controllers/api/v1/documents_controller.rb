class Api::V1::DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session # Temporary
  before_action :set_user

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
    @result = []
    @documents.each do |document|
      @obj = {
        id: document.id,
        document_id: document.document_id,
        document_type_id: document.document_type_id,
        expire_date: document.expire_date,
        statu_id: document.statu_id,
        user_id: document.user_id,
        active: document.active,
        approved: document.approved,
        file: document.file.attached? ? url_for(document.file) : nil,
        created_at: document.created_at,
        updated_at: document.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  def active
    @documents = Document.where(active: true)
    @result = []
    @documents.each do |document|
      @obj = {
        id: document.id,
        document_id: document.document_id,
        document_type_id: document.document_type_id,
        expire_date: document.expire_date,
        statu_id: document.statu_id,
        user_id: document.user_id,
        active: document.active,
        approved: document.approved,
        file: document.file.attached? ? url_for(document.file) : nil,
        created_at: document.created_at,
        updated_at: document.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  def me
    @documents = @user.documents
    @result = []
    @documents.each do |document|
      @obj = {
        id: document.id,
        document_id: document.document_id,
        document_type_id: document.document_type_id,
        expire_date: document.expire_date,
        statu_id: document.statu_id,
        user_id: document.user_id,
        active: document.active,
        approved: document.approved,
        file: document.file.attached? ? url_for(document.file) : nil,
        created_at: document.created_at,
        updated_at: document.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @obj = {
      id: @document.id,
      document_id: @document.document_id,
      document_type_id: @document.document_type_id,
      expire_date: @document.expire_date,
      statu_id: @document.statu_id,
      user_id: @document.user_id,
      active: @document.active,
      approved: @document.approved,
      file: @document.file.attached? ? url_for(@document.file) : nil,
      created_at: @document.created_at,
      updated_at: @document.updated_at
    }
    render json: @obj
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    if @document.save
      @obj = {
        id: @document.id,
        document_id: @document.document_id,
        document_type_id: @document.document_type_id,
        expire_date: @document.expire_date,
        statu_id: @document.statu_id,
        user_id: @document.user_id,
        active: @document.active,
        approved: @document.approved,
        file: @document.file.attached? ? url_for(@document.file) : nil,
        created_at: @document.created_at,
        updated_at: @document.updated_at
      }
      render json: @obj, status: :created, location: @obj
      # 'ticket was successfully created.'
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    if @document.update(document_params)

      @obj = {
        id: @document.id,
        document_id: @document.document_id,
        document_type_id: @document.document_type_id,
        expire_date: @document.expire_date,
        statu_id: @document.statu_id,
        user_id: @document.user_id,
        active: @document.active,
        approved: @document.approved,
        file: @document.file.attached? ? url_for(@document.file) : nil,
        created_at: @document.created_at,
        updated_at: @document.updated_at
      }

      render json: @obj
      # 'ticket was successfully updated.'
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
  end

  private

    def set_user
      @user = User.all.first #User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:document_id, :document_type_id, :file, :statu_id, :user_id, :expire_date, :approved, :active)
    end
end
