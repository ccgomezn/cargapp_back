require 'test_helper'

class VehiclesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vehicle = vehicles(:one)
  end

  test "should get index" do
    get vehicles_url
    assert_response :success
  end

  test "should get new" do
    get new_vehicle_url
    assert_response :success
  end

  test "should create vehicle" do
    assert_difference('Vehicle.count') do
      post vehicles_url, params: { vehicle: { active: @vehicle.active, brand: @vehicle.brand, chassis: @vehicle.chassis, color: @vehicle.color, model: @vehicle.model, model_year: @vehicle.model_year, owner_document_id: @vehicle.owner_document_id, owner_document_type_id: @vehicle.owner_document_type_id, owner_vehicle: @vehicle.owner_vehicle, plate: @vehicle.plate, user_id: @vehicle.user_id, vehicle_type_id: @vehicle.vehicle_type_id } }
    end

    assert_redirected_to vehicle_url(Vehicle.last)
  end

  test "should show vehicle" do
    get vehicle_url(@vehicle)
    assert_response :success
  end

  test "should get edit" do
    get edit_vehicle_url(@vehicle)
    assert_response :success
  end

  test "should update vehicle" do
    patch vehicle_url(@vehicle), params: { vehicle: { active: @vehicle.active, brand: @vehicle.brand, chassis: @vehicle.chassis, color: @vehicle.color, model: @vehicle.model, model_year: @vehicle.model_year, owner_document_id: @vehicle.owner_document_id, owner_document_type_id: @vehicle.owner_document_type_id, owner_vehicle: @vehicle.owner_vehicle, plate: @vehicle.plate, user_id: @vehicle.user_id, vehicle_type_id: @vehicle.vehicle_type_id } }
    assert_redirected_to vehicle_url(@vehicle)
  end

  test "should destroy vehicle" do
    assert_difference('Vehicle.count', -1) do
      delete vehicle_url(@vehicle)
    end

    assert_redirected_to vehicles_url
  end
end
