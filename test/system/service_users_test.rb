require "application_system_test_case"

class ServiceUsersTest < ApplicationSystemTestCase
  setup do
    @service_user = service_users(:one)
  end

  test "visiting the index" do
    visit service_users_url
    assert_selector "h1", text: "Service Users"
  end

  test "creating a Service user" do
    visit service_users_url
    click_on "New Service User"

    check "Active" if @service_user.active
    check "Approved" if @service_user.approved
    fill_in "Expiration date", with: @service_user.expiration_date
    fill_in "Position", with: @service_user.position
    fill_in "Service", with: @service_user.service_id
    fill_in "User", with: @service_user.user_id
    click_on "Create Service user"

    assert_text "Service user was successfully created"
    click_on "Back"
  end

  test "updating a Service user" do
    visit service_users_url
    click_on "Edit", match: :first

    check "Active" if @service_user.active
    check "Approved" if @service_user.approved
    fill_in "Expiration date", with: @service_user.expiration_date
    fill_in "Position", with: @service_user.position
    fill_in "Service", with: @service_user.service_id
    fill_in "User", with: @service_user.user_id
    click_on "Update Service user"

    assert_text "Service user was successfully updated"
    click_on "Back"
  end

  test "destroying a Service user" do
    visit service_users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Service user was successfully destroyed"
  end
end
