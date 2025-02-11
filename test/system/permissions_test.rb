require "application_system_test_case"

class PermissionsTest < ApplicationSystemTestCase
  setup do
    @permission = permissions(:one)
  end

  test "visiting the index" do
    visit permissions_url
    assert_selector "h1", text: "Permissions"
  end

  test "creating a Permission" do
    visit permissions_url
    click_on "New Permission"

    fill_in "Action", with: @permission.action
    check "Active" if @permission.active
    check "Allow" if @permission.allow
    fill_in "Cargapp model", with: @permission.cargapp_model_id
    fill_in "Method", with: @permission.method
    fill_in "Role", with: @permission.role_id
    fill_in "User", with: @permission.user_id
    click_on "Create Permission"

    assert_text "Permission was successfully created"
    click_on "Back"
  end

  test "updating a Permission" do
    visit permissions_url
    click_on "Edit", match: :first

    fill_in "Action", with: @permission.action
    check "Active" if @permission.active
    check "Allow" if @permission.allow
    fill_in "Cargapp model", with: @permission.cargapp_model_id
    fill_in "Method", with: @permission.method
    fill_in "Role", with: @permission.role_id
    fill_in "User", with: @permission.user_id
    click_on "Update Permission"

    assert_text "Permission was successfully updated"
    click_on "Back"
  end

  test "destroying a Permission" do
    visit permissions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Permission was successfully destroyed"
  end
end
