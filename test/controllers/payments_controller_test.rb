require 'test_helper'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment = payments(:one)
  end

  test "should get index" do
    get payments_url
    assert_response :success
  end

  test "should get new" do
    get new_payment_url
    assert_response :success
  end

  test "should create payment" do
    assert_difference('Payment.count') do
      post payments_url, params: { payment: { active: @payment.active, coupon_amount: @payment.coupon_amount, coupon_code: @payment.coupon_code, coupon_id: @payment.coupon_id, is_service: @payment.is_service, observation: @payment.observation, payment_method_id: @payment.payment_method_id, service_id: @payment.service_id, statu_id: @payment.statu_id, sub_total: @payment.sub_total, taxes: @payment.taxes, total: @payment.total, transaction_code: @payment.transaction_code, user_id: @payment.user_id, user_payment_method_id: @payment.user_payment_method_id, uuid: @payment.uuid } }
    end

    assert_redirected_to payment_url(Payment.last)
  end

  test "should show payment" do
    get payment_url(@payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_payment_url(@payment)
    assert_response :success
  end

  test "should update payment" do
    patch payment_url(@payment), params: { payment: { active: @payment.active, coupon_amount: @payment.coupon_amount, coupon_code: @payment.coupon_code, coupon_id: @payment.coupon_id, is_service: @payment.is_service, observation: @payment.observation, payment_method_id: @payment.payment_method_id, service_id: @payment.service_id, statu_id: @payment.statu_id, sub_total: @payment.sub_total, taxes: @payment.taxes, total: @payment.total, transaction_code: @payment.transaction_code, user_id: @payment.user_id, user_payment_method_id: @payment.user_payment_method_id, uuid: @payment.uuid } }
    assert_redirected_to payment_url(@payment)
  end

  test "should destroy payment" do
    assert_difference('Payment.count', -1) do
      delete payment_url(@payment)
    end

    assert_redirected_to payments_url
  end
end
