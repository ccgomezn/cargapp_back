require "application_system_test_case"

class VehiclesTest < ApplicationSystemTestCase
  setup do
    @vehicle = vehicles(:one)
  end

  test "visiting the index" do
    visit vehicles_url
    assert_selector "h1", text: "Vehicles"
  end

  test "creating a Vehicle" do
    visit vehicles_url
    click_on "New Vehicle"

    check "Active" if @vehicle.active
    fill_in "Brand", with: @vehicle.brand
    fill_in "Chassis", with: @vehicle.chassis
    fill_in "Color", with: @vehicle.color
    fill_in "Model", with: @vehicle.model
    fill_in "Model year", with: @vehicle.model_year
    fill_in "Owner document", with: @vehicle.owner_document_id
    fill_in "Owner document type", with: @vehicle.owner_document_type_id
    fill_in "Owner vehicle", with: @vehicle.owner_vehicle
    fill_in "Plate", with: @vehicle.plate
    fill_in "User", with: @vehicle.user_id
    fill_in "Vehicle type", with: @vehicle.vehicle_type_id
    click_on "Create Vehicle"

    assert_text "Vehicle was successfully created"
    click_on "Back"
  end

  test "updating a Vehicle" do
    visit vehicles_url
    click_on "Edit", match: :first

    check "Active" if @vehicle.active
    fill_in "Brand", with: @vehicle.brand
    fill_in "Chassis", with: @vehicle.chassis
    fill_in "Color", with: @vehicle.color
    fill_in "Model", with: @vehicle.model
    fill_in "Model year", with: @vehicle.model_year
    fill_in "Owner document", with: @vehicle.owner_document_id
    fill_in "Owner document type", with: @vehicle.owner_document_type_id
    fill_in "Owner vehicle", with: @vehicle.owner_vehicle
    fill_in "Plate", with: @vehicle.plate
    fill_in "User", with: @vehicle.user_id
    fill_in "Vehicle type", with: @vehicle.vehicle_type_id
    click_on "Update Vehicle"

    assert_text "Vehicle was successfully updated"
    click_on "Back"
  end

  test "destroying a Vehicle" do
    visit vehicles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vehicle was successfully destroyed"
  end
end
