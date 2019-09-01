require "application_system_test_case"

class ServiceLocationsTest < ApplicationSystemTestCase
  setup do
    @service_location = service_locations(:one)
  end

  test "visiting the index" do
    visit service_locations_url
    assert_selector "h1", text: "Service Locations"
  end

  test "creating a Service location" do
    visit service_locations_url
    click_on "New Service Location"

    check "Active" if @service_location.active
    fill_in "City", with: @service_location.city_id
    fill_in "Latitude", with: @service_location.latitude
    fill_in "Longitude", with: @service_location.longitude
    fill_in "Service", with: @service_location.service_id
    fill_in "User", with: @service_location.user_id
    click_on "Create Service location"

    assert_text "Service location was successfully created"
    click_on "Back"
  end

  test "updating a Service location" do
    visit service_locations_url
    click_on "Edit", match: :first

    check "Active" if @service_location.active
    fill_in "City", with: @service_location.city_id
    fill_in "Latitude", with: @service_location.latitude
    fill_in "Longitude", with: @service_location.longitude
    fill_in "Service", with: @service_location.service_id
    fill_in "User", with: @service_location.user_id
    click_on "Update Service location"

    assert_text "Service location was successfully updated"
    click_on "Back"
  end

  test "destroying a Service location" do
    visit service_locations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Service location was successfully destroyed"
  end
end
