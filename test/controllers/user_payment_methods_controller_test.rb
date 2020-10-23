require 'test_helper'

class UserPaymentMethodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_payment_method = user_payment_methods(:one)
  end

  test "should get index" do
    get user_payment_methods_url
    assert_response :success
  end

  test "should get new" do
    get new_user_payment_method_url
    assert_response :success
  end

  test "should create user_payment_method" do
    assert_difference('UserPaymentMethod.count') do
      post user_payment_methods_url, params: { user_payment_method: { active: @user_payment_method.active, card_number: @user_payment_method.card_number, cvv: @user_payment_method.cvv, email: @user_payment_method.email, expiration: @user_payment_method.expiration, observation: @user_payment_method.observation, payment_method_id: @user_payment_method.payment_method_id, token: @user_payment_method.token, user_id: @user_payment_method.user_id, uuid: @user_payment_method.uuid } }
    end

    assert_redirected_to user_payment_method_url(UserPaymentMethod.last)
  end

  test "should show user_payment_method" do
    get user_payment_method_url(@user_payment_method)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_payment_method_url(@user_payment_method)
    assert_response :success
  end

  test "should update user_payment_method" do
    patch user_payment_method_url(@user_payment_method), params: { user_payment_method: { active: @user_payment_method.active, card_number: @user_payment_method.card_number, cvv: @user_payment_method.cvv, email: @user_payment_method.email, expiration: @user_payment_method.expiration, observation: @user_payment_method.observation, payment_method_id: @user_payment_method.payment_method_id, token: @user_payment_method.token, user_id: @user_payment_method.user_id, uuid: @user_payment_method.uuid } }
    assert_redirected_to user_payment_method_url(@user_payment_method)
  end

  test "should destroy user_payment_method" do
    assert_difference('UserPaymentMethod.count', -1) do
      delete user_payment_method_url(@user_payment_method)
    end

    assert_redirected_to user_payment_methods_url
  end
end
