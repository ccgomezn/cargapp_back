require "application_system_test_case"

class ServicesTest < ApplicationSystemTestCase
  setup do
    @service = services(:one)
  end

  test "visiting the index" do
    visit services_url
    assert_selector "h1", text: "Services"
  end

  test "creating a Service" do
    visit services_url
    click_on "New Service"

    check "Active" if @service.active
    fill_in "Company", with: @service.company_id
    fill_in "Contact", with: @service.contact
    fill_in "Description", with: @service.description
    fill_in "Destination", with: @service.destination
    fill_in "Destination address", with: @service.destination_address
    fill_in "Destination city", with: @service.destination_city_id
    fill_in "Destination latitude", with: @service.destination_latitude
    fill_in "Destination longitude", with: @service.destination_longitude
    fill_in "Expiration date", with: @service.expiration_date
    fill_in "Name", with: @service.name
    fill_in "Note", with: @service.note
    fill_in "Origin", with: @service.origin
    fill_in "Origin address", with: @service.origin_address
    fill_in "Origin city", with: @service.origin_city_id
    fill_in "Origin latitude", with: @service.origin_latitude
    fill_in "Origin longitude", with: @service.origin_longitude
    fill_in "Price", with: @service.price
    fill_in "Statu", with: @service.statu_id
    fill_in "User driver", with: @service.user_driver_id
    fill_in "User", with: @service.user_id
    fill_in "User receiver", with: @service.user_receiver_id
    fill_in "Vehicle", with: @service.vehicle_id
    fill_in "Vehicle type", with: @service.vehicle_type_id
    click_on "Create Service"

    assert_text "Service was successfully created"
    click_on "Back"
  end

  test "updating a Service" do
    visit services_url
    click_on "Edit", match: :first

    check "Active" if @service.active
    fill_in "Company", with: @service.company_id
    fill_in "Contact", with: @service.contact
    fill_in "Description", with: @service.description
    fill_in "Destination", with: @service.destination
    fill_in "Destination address", with: @service.destination_address
    fill_in "Destination city", with: @service.destination_city_id
    fill_in "Destination latitude", with: @service.destination_latitude
    fill_in "Destination longitude", with: @service.destination_longitude
    fill_in "Expiration date", with: @service.expiration_date
    fill_in "Name", with: @service.name
    fill_in "Note", with: @service.note
    fill_in "Origin", with: @service.origin
    fill_in "Origin address", with: @service.origin_address
    fill_in "Origin city", with: @service.origin_city_id
    fill_in "Origin latitude", with: @service.origin_latitude
    fill_in "Origin longitude", with: @service.origin_longitude
    fill_in "Price", with: @service.price
    fill_in "Statu", with: @service.statu_id
    fill_in "User driver", with: @service.user_driver_id
    fill_in "User", with: @service.user_id
    fill_in "User receiver", with: @service.user_receiver_id
    fill_in "Vehicle", with: @service.vehicle_id
    fill_in "Vehicle type", with: @service.vehicle_type_id
    click_on "Update Service"

    assert_text "Service was successfully updated"
    click_on "Back"
  end

  test "destroying a Service" do
    visit services_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Service was successfully destroyed"
  end
end
