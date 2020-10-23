require 'test_helper'

class ServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service = services(:one)
  end

  test "should get index" do
    get services_url
    assert_response :success
  end

  test "should get new" do
    get new_service_url
    assert_response :success
  end

  test "should create service" do
    assert_difference('Service.count') do
      post services_url, params: { service: { active: @service.active, company_id: @service.company_id, contact: @service.contact, description: @service.description, destination: @service.destination, destination_address: @service.destination_address, destination_city_id: @service.destination_city_id, destination_latitude: @service.destination_latitude, destination_longitude: @service.destination_longitude, expiration_date: @service.expiration_date, name: @service.name, note: @service.note, origin: @service.origin, origin_address: @service.origin_address, origin_city_id: @service.origin_city_id, origin_latitude: @service.origin_latitude, origin_longitude: @service.origin_longitude, price: @service.price, statu_id: @service.statu_id, user_driver_id: @service.user_driver_id, user_id: @service.user_id, user_receiver_id: @service.user_receiver_id, vehicle_id: @service.vehicle_id, vehicle_type_id: @service.vehicle_type_id } }
    end

    assert_redirected_to service_url(Service.last)
  end

  test "should show service" do
    get service_url(@service)
    assert_response :success
  end

  test "should get edit" do
    get edit_service_url(@service)
    assert_response :success
  end

  test "should update service" do
    patch service_url(@service), params: { service: { active: @service.active, company_id: @service.company_id, contact: @service.contact, description: @service.description, destination: @service.destination, destination_address: @service.destination_address, destination_city_id: @service.destination_city_id, destination_latitude: @service.destination_latitude, destination_longitude: @service.destination_longitude, expiration_date: @service.expiration_date, name: @service.name, note: @service.note, origin: @service.origin, origin_address: @service.origin_address, origin_city_id: @service.origin_city_id, origin_latitude: @service.origin_latitude, origin_longitude: @service.origin_longitude, price: @service.price, statu_id: @service.statu_id, user_driver_id: @service.user_driver_id, user_id: @service.user_id, user_receiver_id: @service.user_receiver_id, vehicle_id: @service.vehicle_id, vehicle_type_id: @service.vehicle_type_id } }
    assert_redirected_to service_url(@service)
  end

  test "should destroy service" do
    assert_difference('Service.count', -1) do
      delete service_url(@service)
    end

    assert_redirected_to services_url
  end
end
