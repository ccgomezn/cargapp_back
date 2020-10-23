require 'test_helper'

class StatusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @status = status(:one)
  end

  test "should get index" do
    get status_url
    assert_response :success
  end

  test "should get new" do
    get new_status_url
    assert_response :success
  end

  test "should create status" do
    assert_difference('Statu.count') do
      post status_url, params: { status: { active: @status.active, cargapp_model_id: @status.cargapp_model_id, code: @status.code, description: @status.description, name: @status.name, user_id: @status.user_id } }
    end

    assert_redirected_to status_url(Statu.last)
  end

  test "should show status" do
    get status_url(@status)
    assert_response :success
  end

  test "should get edit" do
    get edit_status_url(@status)
    assert_response :success
  end

  test "should update status" do
    patch status_url(@status), params: { status: { active: @status.active, cargapp_model_id: @status.cargapp_model_id, code: @status.code, description: @status.description, name: @status.name, user_id: @status.user_id } }
    assert_redirected_to status_url(@status)
  end

  test "should destroy status" do
    assert_difference('Statu.count', -1) do
      delete status_url(@status)
    end

    assert_redirected_to status_url
  end
end
