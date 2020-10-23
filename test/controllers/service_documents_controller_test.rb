require 'test_helper'

class ServiceDocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service_document = service_documents(:one)
  end

  test "should get index" do
    get service_documents_url
    assert_response :success
  end

  test "should get new" do
    get new_service_document_url
    assert_response :success
  end

  test "should create service_document" do
    assert_difference('ServiceDocument.count') do
      post service_documents_url, params: { service_document: { active: @service_document.active, document: @service_document.document, document_type: @service_document.document_type, name: @service_document.name, service_id: @service_document.service_id, user_id: @service_document.user_id } }
    end

    assert_redirected_to service_document_url(ServiceDocument.last)
  end

  test "should show service_document" do
    get service_document_url(@service_document)
    assert_response :success
  end

  test "should get edit" do
    get edit_service_document_url(@service_document)
    assert_response :success
  end

  test "should update service_document" do
    patch service_document_url(@service_document), params: { service_document: { active: @service_document.active, document: @service_document.document, document_type: @service_document.document_type, name: @service_document.name, service_id: @service_document.service_id, user_id: @service_document.user_id } }
    assert_redirected_to service_document_url(@service_document)
  end

  test "should destroy service_document" do
    assert_difference('ServiceDocument.count', -1) do
      delete service_document_url(@service_document)
    end

    assert_redirected_to service_documents_url
  end
end
