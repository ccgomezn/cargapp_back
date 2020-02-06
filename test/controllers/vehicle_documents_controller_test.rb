require 'test_helper'

class VehicleDocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vehicle_document = vehicle_documents(:one)
  end

  test "should get index" do
    get vehicle_documents_url
    assert_response :success
  end

  test "should get new" do
    get new_vehicle_document_url
    assert_response :success
  end

  test "should create vehicle_document" do
    assert_difference('VehicleDocument.count') do
      post vehicle_documents_url, params: { vehicle_document: { active: @vehicle_document.active, approved: @vehicle_document.approved, document_type_id: @vehicle_document.document_type_id, expire_date: @vehicle_document.expire_date, file: @vehicle_document.file, statu_id: @vehicle_document.statu_id, user_id: @vehicle_document.user_id, vehicle_id: @vehicle_document.vehicle_id } }
    end

    assert_redirected_to vehicle_document_url(VehicleDocument.last)
  end

  test "should show vehicle_document" do
    get vehicle_document_url(@vehicle_document)
    assert_response :success
  end

  test "should get edit" do
    get edit_vehicle_document_url(@vehicle_document)
    assert_response :success
  end

  test "should update vehicle_document" do
    patch vehicle_document_url(@vehicle_document), params: { vehicle_document: { active: @vehicle_document.active, approved: @vehicle_document.approved, document_type_id: @vehicle_document.document_type_id, expire_date: @vehicle_document.expire_date, file: @vehicle_document.file, statu_id: @vehicle_document.statu_id, user_id: @vehicle_document.user_id, vehicle_id: @vehicle_document.vehicle_id } }
    assert_redirected_to vehicle_document_url(@vehicle_document)
  end

  test "should destroy vehicle_document" do
    assert_difference('VehicleDocument.count', -1) do
      delete vehicle_document_url(@vehicle_document)
    end

    assert_redirected_to vehicle_documents_url
  end
end
