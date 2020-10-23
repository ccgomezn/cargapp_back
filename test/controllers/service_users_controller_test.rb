require 'test_helper'

class ServiceUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service_user = service_users(:one)
  end

  test "should get index" do
    get service_users_url
    assert_response :success
  end

  test "should get new" do
    get new_service_user_url
    assert_response :success
  end

  test "should create service_user" do
    assert_difference('ServiceUser.count') do
      post service_users_url, params: { service_user: { active: @service_user.active, approved: @service_user.approved, expiration_date: @service_user.expiration_date, position: @service_user.position, service_id: @service_user.service_id, user_id: @service_user.user_id } }
    end

    assert_redirected_to service_user_url(ServiceUser.last)
  end

  test "should show service_user" do
    get service_user_url(@service_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_service_user_url(@service_user)
    assert_response :success
  end

  test "should update service_user" do
    patch service_user_url(@service_user), params: { service_user: { active: @service_user.active, approved: @service_user.approved, expiration_date: @service_user.expiration_date, position: @service_user.position, service_id: @service_user.service_id, user_id: @service_user.user_id } }
    assert_redirected_to service_user_url(@service_user)
  end

  test "should destroy service_user" do
    assert_difference('ServiceUser.count', -1) do
      delete service_user_url(@service_user)
    end

    assert_redirected_to service_users_url
  end
end
