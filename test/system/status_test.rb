require "application_system_test_case"

class StatusTest < ApplicationSystemTestCase
  setup do
    @status = status(:one)
  end

  test "visiting the index" do
    visit status_url
    assert_selector "h1", text: "Status"
  end

  test "creating a Statu" do
    visit status_url
    click_on "New Statu"

    check "Active" if @status.active
    fill_in "Cargapp model", with: @status.cargapp_model_id
    fill_in "Code", with: @status.code
    fill_in "Description", with: @status.description
    fill_in "Name", with: @status.name
    fill_in "User", with: @status.user_id
    click_on "Create Statu"

    assert_text "Statu was successfully created"
    click_on "Back"
  end

  test "updating a Statu" do
    visit status_url
    click_on "Edit", match: :first

    check "Active" if @status.active
    fill_in "Cargapp model", with: @status.cargapp_model_id
    fill_in "Code", with: @status.code
    fill_in "Description", with: @status.description
    fill_in "Name", with: @status.name
    fill_in "User", with: @status.user_id
    click_on "Update Statu"

    assert_text "Statu was successfully updated"
    click_on "Back"
  end

  test "destroying a Statu" do
    visit status_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Statu was successfully destroyed"
  end
end
