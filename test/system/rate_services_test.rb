require "application_system_test_case"

class RateServicesTest < ApplicationSystemTestCase
  setup do
    @rate_service = rate_services(:one)
  end

  test "visiting the index" do
    visit rate_services_url
    assert_selector "h1", text: "Rate Services"
  end

  test "creating a Rate service" do
    visit rate_services_url
    click_on "New Rate Service"

    check "Active" if @rate_service.active
    fill_in "Driver", with: @rate_service.driver_id
    fill_in "Driver point", with: @rate_service.driver_point
    fill_in "Point", with: @rate_service.point
    fill_in "Service", with: @rate_service.service_id
    fill_in "Service point", with: @rate_service.service_point
    fill_in "User", with: @rate_service.user_id
    click_on "Create Rate service"

    assert_text "Rate service was successfully created"
    click_on "Back"
  end

  test "updating a Rate service" do
    visit rate_services_url
    click_on "Edit", match: :first

    check "Active" if @rate_service.active
    fill_in "Driver", with: @rate_service.driver_id
    fill_in "Driver point", with: @rate_service.driver_point
    fill_in "Point", with: @rate_service.point
    fill_in "Service", with: @rate_service.service_id
    fill_in "Service point", with: @rate_service.service_point
    fill_in "User", with: @rate_service.user_id
    click_on "Update Rate service"

    assert_text "Rate service was successfully updated"
    click_on "Back"
  end

  test "destroying a Rate service" do
    visit rate_services_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rate service was successfully destroyed"
  end
end
