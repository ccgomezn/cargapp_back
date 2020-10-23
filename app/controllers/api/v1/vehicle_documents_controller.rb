# frozen_string_literal: true

class Api::V1::VehicleDocumentsController < ApplicationController
  before_action :set_vehicle_document, only: %i[show edit update destroy]
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  before_action :set_user

  # GET /vehicle_documents
  # GET /vehicle_documents.json
  def index
    @vehicle_documents = VehicleDocument.all

    @result = []
    @vehicle_documents.each do |document|
      @obj = {
        id: document.id,
        document_type_id: document.document_type_id,
        expire_date: document.expire_date,
        statu_id: document.statu_id,
        user_id: document.user_id,
        vehicle_id: document.vehicle_id,
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
    @vehicle_documents = VehicleDocument.where(active: true)

    @result = []
    @vehicle_documents.each do |document|
      @obj = {
        id: document.id,
        document_type_id: document.document_type_id,
        expire_date: document.expire_date,
        statu_id: document.statu_id,
        user_id: document.user_id,
        vehicle_id: document.vehicle_id,
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

  def find_by_vehicle
    @vehicle_documents = VehicleDocument.where(active: true, vehicle_id: params[:id])

    @result = []
    @vehicle_documents.each do |document|
      @obj = {
        id: document.id,
        document_type_id: document.document_type_id,
        expire_date: document.expire_date,
        statu_id: document.statu_id,
        user_id: document.user_id,
        vehicle_id: document.vehicle_id,
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

  # GET /vehicle_documents/1
  # GET /vehicle_documents/1.json
  def show
    @obj = {
      id: @vehicle_document.id,
      document_type_id: @vehicle_document.document_type_id,
      expire_date: @vehicle_document.expire_date,
      statu_id: @vehicle_document.statu_id,
      user_id: @vehicle_document.user_id,
      vehicle_id: @vehicle_document.vehicle_id,
      active: @vehicle_document.active,
      approved: @vehicle_document.approved,
      file: @vehicle_document.file.attached? ? url_for(@vehicle_document.file) : nil,
      created_at: @vehicle_document.created_at,
      updated_at: @vehicle_document.updated_at
    }
    render json: @obj
  end

  def me
    @vehicle_documents = VehicleDocument.where(active: true, vehicle_id: params[:vehicle_id], user_id: @user.id)

    @result = []
    @vehicle_documents.each do |document|
      @obj = {
        id: document.id,
        document_type_id: document.document_type_id,
        expire_date: document.expire_date,
        statu_id: document.statu_id,
        user_id: document.user_id,
        vehicle_id: document.vehicle_id,
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

  # POST /vehicle_documents
  # POST /vehicle_documents.json
  def create
    @vehicle_document = VehicleDocument.new(vehicle_document_params)

    if @vehicle_document.save
      @obj = {
        id: @vehicle_document.id,
        document_type_id: @vehicle_document.document_type_id,
        expire_date: @vehicle_document.expire_date,
        statu_id: @vehicle_document.statu_id,
        user_id: @vehicle_document.user_id,
        vehicle_id: @vehicle_document.vehicle_id,
        active: @vehicle_document.active,
        approved: @vehicle_document.approved,
        file: @vehicle_document.file.attached? ? url_for(@vehicle_document.file) : nil,
        created_at: @vehicle_document.created_at,
        updated_at: @vehicle_document.updated_at
      }
      render json: @obj, status: :created, location: @obj
      # 'ticket was successfully created.'
    else
      render json: @vehicle_document.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vehicle_documents/1
  # PATCH/PUT /vehicle_documents/1.json
  def update
    if @vehicle_document.update(vehicle_document_params)

      @obj = {
        id: @vehicle_document.id,
        document_type_id: @vehicle_document.document_type_id,
        expire_date: @vehicle_document.expire_date,
        statu_id: @vehicle_document.statu_id,
        user_id: @vehicle_document.user_id,
        vehicle_id: @vehicle_document.vehicle_id,
        active: @vehicle_document.active,
        approved: @vehicle_document.approved,
        file: @vehicle_document.file.attached? ? url_for(@vehicle_document.file) : nil,
        created_at: @vehicle_document.created_at,
        updated_at: @vehicle_document.updated_at
      }

      render json: @obj
      # 'ticket was successfully updated.'
    else
      render json: @vehicle_document.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vehicle_documents/1
  # DELETE /vehicle_documents/1.json
  def destroy
    @vehicle_document.destroy
  end

  private

  def set_user
    @user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    permissions
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

      has_permission = true if if_super

      if has_permission
        true
      else
        response = { response: 'Does not have permissions' }
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
        response = { response: 'Does not have permissions' }
        render json: response, status: :unprocessable_entity
      end
    end
  end

  def if_super
    @if_super = (User.is_super?(@user) if @user) || false
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_vehicle_document
    @vehicle_document = VehicleDocument.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vehicle_document_params
    params.require(:vehicle_document).permit(:document_type_id, :file, :statu_id, :user_id, :expire_date, :approved, :active, :vehicle_id)
  end
end
