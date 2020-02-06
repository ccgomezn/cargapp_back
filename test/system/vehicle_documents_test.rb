require "application_system_test_case"

class VehicleDocumentsTest < ApplicationSystemTestCase
  setup do
    @vehicle_document = vehicle_documents(:one)
  end

  test "visiting the index" do
    visit vehicle_documents_url
    assert_selector "h1", text: "Vehicle Documents"
  end

  test "creating a Vehicle document" do
    visit vehicle_documents_url
    click_on "New Vehicle Document"

    check "Active" if @vehicle_document.active
    check "Approved" if @vehicle_document.approved
    fill_in "Document type", with: @vehicle_document.document_type_id
    fill_in "Expire date", with: @vehicle_document.expire_date
    fill_in "File", with: @vehicle_document.file
    fill_in "Statu", with: @vehicle_document.statu_id
    fill_in "User", with: @vehicle_document.user_id
    fill_in "Vehicle", with: @vehicle_document.vehicle_id
    click_on "Create Vehicle document"

    assert_text "Vehicle document was successfully created"
    click_on "Back"
  end

  test "updating a Vehicle document" do
    visit vehicle_documents_url
    click_on "Edit", match: :first

    check "Active" if @vehicle_document.active
    check "Approved" if @vehicle_document.approved
    fill_in "Document type", with: @vehicle_document.document_type_id
    fill_in "Expire date", with: @vehicle_document.expire_date
    fill_in "File", with: @vehicle_document.file
    fill_in "Statu", with: @vehicle_document.statu_id
    fill_in "User", with: @vehicle_document.user_id
    fill_in "Vehicle", with: @vehicle_document.vehicle_id
    click_on "Update Vehicle document"

    assert_text "Vehicle document was successfully updated"
    click_on "Back"
  end

  test "destroying a Vehicle document" do
    visit vehicle_documents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vehicle document was successfully destroyed"
  end
end
