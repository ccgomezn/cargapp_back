require "application_system_test_case"

class ServiceDocumentsTest < ApplicationSystemTestCase
  setup do
    @service_document = service_documents(:one)
  end

  test "visiting the index" do
    visit service_documents_url
    assert_selector "h1", text: "Service Documents"
  end

  test "creating a Service document" do
    visit service_documents_url
    click_on "New Service Document"

    check "Active" if @service_document.active
    fill_in "Document", with: @service_document.document
    fill_in "Document type", with: @service_document.document_type
    fill_in "Name", with: @service_document.name
    fill_in "Service", with: @service_document.service_id
    fill_in "User", with: @service_document.user_id
    click_on "Create Service document"

    assert_text "Service document was successfully created"
    click_on "Back"
  end

  test "updating a Service document" do
    visit service_documents_url
    click_on "Edit", match: :first

    check "Active" if @service_document.active
    fill_in "Document", with: @service_document.document
    fill_in "Document type", with: @service_document.document_type
    fill_in "Name", with: @service_document.name
    fill_in "Service", with: @service_document.service_id
    fill_in "User", with: @service_document.user_id
    click_on "Update Service document"

    assert_text "Service document was successfully updated"
    click_on "Back"
  end

  test "destroying a Service document" do
    visit service_documents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Service document was successfully destroyed"
  end
end
