require 'test_helper'

class CouponsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coupon = coupons(:one)
  end

  test "should get index" do
    get coupons_url
    assert_response :success
  end

  test "should get new" do
    get new_coupon_url
    assert_response :success
  end

  test "should create coupon" do
    assert_difference('Coupon.count') do
      post coupons_url, params: { coupon: { active: @coupon.active, cargapp_model_id: @coupon.cargapp_model_id, code: @coupon.code, description: @coupon.description, is_porcentage: @coupon.is_porcentage, name: @coupon.name, quantity: @coupon.quantity, user_id: @coupon.user_id, value: @coupon.value } }
    end

    assert_redirected_to coupon_url(Coupon.last)
  end

  test "should show coupon" do
    get coupon_url(@coupon)
    assert_response :success
  end

  test "should get edit" do
    get edit_coupon_url(@coupon)
    assert_response :success
  end

  test "should update coupon" do
    patch coupon_url(@coupon), params: { coupon: { active: @coupon.active, cargapp_model_id: @coupon.cargapp_model_id, code: @coupon.code, description: @coupon.description, is_porcentage: @coupon.is_porcentage, name: @coupon.name, quantity: @coupon.quantity, user_id: @coupon.user_id, value: @coupon.value } }
    assert_redirected_to coupon_url(@coupon)
  end

  test "should destroy coupon" do
    assert_difference('Coupon.count', -1) do
      delete coupon_url(@coupon)
    end

    assert_redirected_to coupons_url
  end
end
