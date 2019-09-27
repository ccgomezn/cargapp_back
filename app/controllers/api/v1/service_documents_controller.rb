class Api::V1::ServiceDocumentsController < ApplicationController
  before_action :set_service_document, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user


  swagger_controller :serviceDocument, 'Service Documents Management'

  swagger_api :index do
    summary 'Fetches all Service Document items'
    notes 'This lists all the service documents'
  end

  swagger_api :active do
    summary 'Fetches all active Service Document items'
    notes 'This lists all the active service documents'
  end

  swagger_api :create do
    summary 'Creates a new Service Document'
    param :form, 'service_document[name]', :string, :required, 'Name'
    param :form, 'service_document[document_type]', :string, :required, 'Document Type'
    param :form, 'service_document[document]', :file, :required, 'Document'
    param :form, 'service_document[service_id]', :integer, :required, 'Id of service related'
    param :form, 'service_document[user_id]', :integer, :required, 'Id of user related'
    param :form, 'service_document[active]', :boolean, :required, 'State of activation'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary 'Updates an existing Service Document'
    param :path, :id, :integer, :required, "Service Document Id"
    param :form, 'service_document[name]', :string, :optional, 'Name'
    param :form, 'service_document[document_type]', :string, :optional, 'Document Type'
    param :form, 'service_document[document]', :file, :optional, 'Document'
    param :form, 'service_document[service_id]', :integer, :optional, 'Id of service related'
    param :form, 'service_document[user_id]', :integer, :optional, 'Id of user related'
    param :form, 'service_document[active]', :boolean, :optional, 'State of activation'
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Service Document"
    param :path, :id, :integer, :optional, "Service Document Id"
    response :unauthorized
    response :not_found
  end

  swagger_api :show do
    summary "Shows Service Document"
    param :path, :id, :integer, :optional, "Service Document Id"
    response :unauthorized
    response :not_found
  end

  swagger_api :me do
    summary "Shows mine Service Document"
    response :unauthorized
  end

  swagger_api :find_service do
    summary "Shows Service Documents of an specific service"
    param :path, :id, :integer, :optional, "Service Id"
    response :unauthorized
    response :not_found
  end

  # GET /service_documents
  # GET /service_documents.json
  def index
    @service_documents = ServiceDocument.all

    @result = []
    @service_documents.each do |document|
      @obj = {
        id: document.id,
        name: document.name,  
        document_type: document.document_type,
        document: document.document.attached? ? url_for(document.document) : nil,
        service_id: document.service_id,
        user_id: document.user_id,
        active: document.active,        
        created_at: document.created_at,
        updated_at: document.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  def active
    @service_documents = ServiceDocument.where(active: true)

    @result = []
    @service_documents.each do |document|
      @obj = {
        id: document.id,
        name: document.name,
        document_type: document.document_type,
        document: document.document.attached? ? url_for(document.document) : nil,
        service_id: document.service_id,
        user_id: document.user_id,
        active: document.active,        
        created_at: document.created_at,
        updated_at: document.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  def me
    @service_documents = @user.service_documents

    @result = []
    @service_documents.each do |document|
      @obj = {
        id: document.id,
        name: document.name,
        document_type: document.document_type,
        document: document.document.attached? ? url_for(document.document) : nil,
        service_id: document.service_id,
        user_id: document.user_id,
        active: document.active,        
        created_at: document.created_at,
        updated_at: document.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  # GET /service_documents/1
  # GET /service_documents/1.json
  def show
    @obj = {
      id: @service_document.id,
      name: document.name,
      document_type: @service_document.document_type,
      document: @service_document.document.attached? ? url_for(@service_document.document) : nil,
      service_id: @service_document.service_id,
      user_id: @service_document.user_id,
      active: @service_document.active,        
      created_at: @service_document.created_at,
      updated_at: @service_document.updated_at
    }
    render json: @obj
  end

  def find_service
    service_id = params[:id]
    @service_documents = ServiceDocument.where(service_id: service_id, active: true)

    @result = []
    @service_documents.each do |document|
      @obj = {
        id: document.id,
        name: document.name,
        document_type: document.document_type,
        document: document.document.attached? ? url_for(document.document) : nil,
        service_id: document.service_id,
        user_id: document.user_id,
        active: document.active,
        created_at: document.created_at,
        updated_at: document.updated_at
      }
      @result << @obj
    end
    render json: @result
  end

  # POST /service_documents
  # POST /service_documents.json
  def create
    @service_document = ServiceDocument.new(service_document_params)
    if @service_document.save
      @obj = {
        id: @service_document.id,
        name: document.name,
        document_type: @service_document.document_type,
        document: @service_document.document.attached? ? url_for(@service_document.document) : nil,
        service_id: @service_document.service_id,
        user_id: @service_document.user_id,
        active: @service_document.active,        
        created_at: @service_document.created_at,
        updated_at: @service_document.updated_at
      }
      render :show, json: @obj, status: :created, location: @service_document
    else
      render json: @service_document.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /service_documents/1
  # PATCH/PUT /service_documents/1.json
  def update
    if @service_document.update(service_document_params)
      @obj = {
        id: @service_document.id,
        name: document.name,
        document_type: @service_document.document_type,
        document: @service_document.document.attached? ? url_for(@service_document.document) : nil,
        service_id: @service_document.service_id,
        user_id: @service_document.user_id,
        active: @service_document.active,        
        created_at: @service_document.created_at,
        updated_at: @service_document.updated_at
      }
      render json: @obj, status: :ok, location: @service_document
    else
      render json: @service_document.errors, status: :unprocessable_entity
    end
  end

  # DELETE /service_documents/1
  # DELETE /service_documents/1.json
  def destroy
    @service_document.destroy
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
    def set_service_document
      @service_document = ServiceDocument.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_document_params
      params.require(:service_document).permit(:name, :document_type, :document, :service_id, :user_id, :active)
    end
end
