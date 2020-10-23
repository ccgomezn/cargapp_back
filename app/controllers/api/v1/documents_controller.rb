class Api::V1::DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user


  swagger_controller :documents, 'Documents Management'

  swagger_api :index do
    summary 'Fetches all Document items'
    notes 'This lists all the documents'
  end

  swagger_api :active do
    summary 'Fetches all active Documt items'
    notes 'This lists all the active documents'
  end

  swagger_api :create do
    summary 'Creates a new Document'
    param :form, 'document[document_id]', :string, :required, 'Id of document'
    param :form, 'document[document_type_id]', :integer, :required, 'Id of type associated to document'
    param :form, 'document[file]', :file, :required, 'File'
    param :form, 'document[status_id]', :integer, :required, 'Id of status associated to document'
    param :form, 'document[user_id]', :integer, :required, 'Id user on coupon'
    param :form, 'document[expire_date]', :string, :required, 'Expiration date of document'
    param :form, 'document[approved]', :boolean, :required, 'Check if document is approved'
    param :form, 'document[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Coupon'
    param :path, :id, :integer, :required, "Coupon Id"
    param :form, 'document[document_id]', :string, :optional, 'Id of document'
    param :form, 'document[document_type_id]', :integer, :optional, 'Id of type associated to document'
    param :form, 'document[file]', :file, :optional, 'File'
    param :form, 'document[status_id]', :integer, :optional, 'Id of status associated to document'
    param :form, 'document[user_id]', :integer, :optional, 'Id user on coupon'
    param :form, 'document[expire_date]', :string, :optional, 'Expiration date of document'
    param :form, 'document[approved]', :boolean, :optional, 'Check if document is approved'
    param :form, 'document[active]', :boolean, :optional, 'State of activation'
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Document"
    param :path, :id, :integer, :optional, "Document Id"
    response :unauthorized
    response :not_found
  end

  swagger_api :me do
    summary 'Fetches mine Document items'
    notes 'This lists mine documents'
  end

  swagger_api :show do
    summary 'Fetches detailed Document items'
    param :path, :id, :integer, :optional, "Document Id"
    notes 'This lists detailed documents'
  end



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

  def find_user
    user = User.find_by(id: params[:user][:id])
    @documents = user.documents.where(active: true)
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
        role = Role.find_by(name: 'USER', active: true)
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
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:document_id, :document_type_id, :file, :statu_id, :user_id, :expire_date, :approved, :active)
    end
end
