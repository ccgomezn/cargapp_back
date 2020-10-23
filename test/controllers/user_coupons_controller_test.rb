require 'test_helper'

class UserCouponsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_coupon = user_coupons(:one)
  end

  test "should get index" do
    get user_coupons_url
    assert_response :success
  end

  test "should get new" do
    get new_user_coupon_url
    assert_response :success
  end

  test "should create user_coupon" do
    assert_difference('UserCoupon.count') do
      post user_coupons_url, params: { user_coupon: { active: @user_coupon.active, applied_item_id: @user_coupon.applied_item_id, cargapp_model_id: @user_coupon.cargapp_model_id, coupon_id: @user_coupon.coupon_id, discount: @user_coupon.discount, user_id: @user_coupon.user_id } }
    end

    assert_redirected_to user_coupon_url(UserCoupon.last)
  end

  test "should show user_coupon" do
    get user_coupon_url(@user_coupon)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_coupon_url(@user_coupon)
    assert_response :success
  end

  test "should update user_coupon" do
    patch user_coupon_url(@user_coupon), params: { user_coupon: { active: @user_coupon.active, applied_item_id: @user_coupon.applied_item_id, cargapp_model_id: @user_coupon.cargapp_model_id, coupon_id: @user_coupon.coupon_id, discount: @user_coupon.discount, user_id: @user_coupon.user_id } }
    assert_redirected_to user_coupon_url(@user_coupon)
  end

  test "should destroy user_coupon" do
    assert_difference('UserCoupon.count', -1) do
      delete user_coupon_url(@user_coupon)
    end

    assert_redirected_to user_coupons_url
  end
end
