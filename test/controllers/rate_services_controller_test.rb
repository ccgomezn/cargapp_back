require 'test_helper'

class RateServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rate_service = rate_services(:one)
  end

  test "should get index" do
    get rate_services_url
    assert_response :success
  end

  test "should get new" do
    get new_rate_service_url
    assert_response :success
  end

  test "should create rate_service" do
    assert_difference('RateService.count') do
      post rate_services_url, params: { rate_service: { active: @rate_service.active, driver_id: @rate_service.driver_id, driver_point: @rate_service.driver_point, point: @rate_service.point, service_id: @rate_service.service_id, service_point: @rate_service.service_point, user_id: @rate_service.user_id } }
    end

    assert_redirected_to rate_service_url(RateService.last)
  end

  test "should show rate_service" do
    get rate_service_url(@rate_service)
    assert_response :success
  end

  test "should get edit" do
    get edit_rate_service_url(@rate_service)
    assert_response :success
  end

  test "should update rate_service" do
    patch rate_service_url(@rate_service), params: { rate_service: { active: @rate_service.active, driver_id: @rate_service.driver_id, driver_point: @rate_service.driver_point, point: @rate_service.point, service_id: @rate_service.service_id, service_point: @rate_service.service_point, user_id: @rate_service.user_id } }
    assert_redirected_to rate_service_url(@rate_service)
  end

  test "should destroy rate_service" do
    assert_difference('RateService.count', -1) do
      delete rate_service_url(@rate_service)
    end

    assert_redirected_to rate_services_url
  end
end
