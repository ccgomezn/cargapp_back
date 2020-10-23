require 'test_helper'

class CargappPaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cargapp_payment = cargapp_payments(:one)
  end

  test "should get index" do
    get cargapp_payments_url
    assert_response :success
  end

  test "should get new" do
    get new_cargapp_payment_url
    assert_response :success
  end

  test "should create cargapp_payment" do
    assert_difference('CargappPayment.count') do
      post cargapp_payments_url, params: { cargapp_payment: { active: @cargapp_payment.active, amount: @cargapp_payment.amount, bank_account_id: @cargapp_payment.bank_account_id, company_id: @cargapp_payment.company_id, generator_id: @cargapp_payment.generator_id, observation: @cargapp_payment.observation, payment_method_id: @cargapp_payment.payment_method_id, receiver_id: @cargapp_payment.receiver_id, service_id: @cargapp_payment.service_id, statu_id: @cargapp_payment.statu_id, transaction_code: @cargapp_payment.transaction_code, user_id: @cargapp_payment.user_id, uuid: @cargapp_payment.uuid } }
    end

    assert_redirected_to cargapp_payment_url(CargappPayment.last)
  end

  test "should show cargapp_payment" do
    get cargapp_payment_url(@cargapp_payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_cargapp_payment_url(@cargapp_payment)
    assert_response :success
  end

  test "should update cargapp_payment" do
    patch cargapp_payment_url(@cargapp_payment), params: { cargapp_payment: { active: @cargapp_payment.active, amount: @cargapp_payment.amount, bank_account_id: @cargapp_payment.bank_account_id, company_id: @cargapp_payment.company_id, generator_id: @cargapp_payment.generator_id, observation: @cargapp_payment.observation, payment_method_id: @cargapp_payment.payment_method_id, receiver_id: @cargapp_payment.receiver_id, service_id: @cargapp_payment.service_id, statu_id: @cargapp_payment.statu_id, transaction_code: @cargapp_payment.transaction_code, user_id: @cargapp_payment.user_id, uuid: @cargapp_payment.uuid } }
    assert_redirected_to cargapp_payment_url(@cargapp_payment)
  end

  test "should destroy cargapp_payment" do
    assert_difference('CargappPayment.count', -1) do
      delete cargapp_payment_url(@cargapp_payment)
    end

    assert_redirected_to cargapp_payments_url
  end
end
