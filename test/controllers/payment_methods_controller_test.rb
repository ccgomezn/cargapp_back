require 'test_helper'

class PaymentMethodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment_method = payment_methods(:one)
  end

  test "should get index" do
    get payment_methods_url
    assert_response :success
  end

  test "should get new" do
    get new_payment_method_url
    assert_response :success
  end

  test "should create payment_method" do
    assert_difference('PaymentMethod.count') do
      post payment_methods_url, params: { payment_method: { aap_id: @payment_method.aap_id, active: @payment_method.active, description: @payment_method.description, email: @payment_method.email, name: @payment_method.name, password: @payment_method.password, secret_id: @payment_method.secret_id, token: @payment_method.token, user_id: @payment_method.user_id, uuid: @payment_method.uuid } }
    end

    assert_redirected_to payment_method_url(PaymentMethod.last)
  end

  test "should show payment_method" do
    get payment_method_url(@payment_method)
    assert_response :success
  end

  test "should get edit" do
    get edit_payment_method_url(@payment_method)
    assert_response :success
  end

  test "should update payment_method" do
    patch payment_method_url(@payment_method), params: { payment_method: { aap_id: @payment_method.aap_id, active: @payment_method.active, description: @payment_method.description, email: @payment_method.email, name: @payment_method.name, password: @payment_method.password, secret_id: @payment_method.secret_id, token: @payment_method.token, user_id: @payment_method.user_id, uuid: @payment_method.uuid } }
    assert_redirected_to payment_method_url(@payment_method)
  end

  test "should destroy payment_method" do
    assert_difference('PaymentMethod.count', -1) do
      delete payment_method_url(@payment_method)
    end

    assert_redirected_to payment_methods_url
  end
end
