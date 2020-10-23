require "application_system_test_case"

class CargappPaymentsTest < ApplicationSystemTestCase
  setup do
    @cargapp_payment = cargapp_payments(:one)
  end

  test "visiting the index" do
    visit cargapp_payments_url
    assert_selector "h1", text: "Cargapp Payments"
  end

  test "creating a Cargapp payment" do
    visit cargapp_payments_url
    click_on "New Cargapp Payment"

    check "Active" if @cargapp_payment.active
    fill_in "Amount", with: @cargapp_payment.amount
    fill_in "Bank account", with: @cargapp_payment.bank_account_id
    fill_in "Company", with: @cargapp_payment.company_id
    fill_in "Generator", with: @cargapp_payment.generator_id
    fill_in "Observation", with: @cargapp_payment.observation
    fill_in "Payment method", with: @cargapp_payment.payment_method_id
    fill_in "Receiver", with: @cargapp_payment.receiver_id
    fill_in "Service", with: @cargapp_payment.service_id
    fill_in "Statu", with: @cargapp_payment.statu_id
    fill_in "Transaction code", with: @cargapp_payment.transaction_code
    fill_in "User", with: @cargapp_payment.user_id
    fill_in "Uuid", with: @cargapp_payment.uuid
    click_on "Create Cargapp payment"

    assert_text "Cargapp payment was successfully created"
    click_on "Back"
  end

  test "updating a Cargapp payment" do
    visit cargapp_payments_url
    click_on "Edit", match: :first

    check "Active" if @cargapp_payment.active
    fill_in "Amount", with: @cargapp_payment.amount
    fill_in "Bank account", with: @cargapp_payment.bank_account_id
    fill_in "Company", with: @cargapp_payment.company_id
    fill_in "Generator", with: @cargapp_payment.generator_id
    fill_in "Observation", with: @cargapp_payment.observation
    fill_in "Payment method", with: @cargapp_payment.payment_method_id
    fill_in "Receiver", with: @cargapp_payment.receiver_id
    fill_in "Service", with: @cargapp_payment.service_id
    fill_in "Statu", with: @cargapp_payment.statu_id
    fill_in "Transaction code", with: @cargapp_payment.transaction_code
    fill_in "User", with: @cargapp_payment.user_id
    fill_in "Uuid", with: @cargapp_payment.uuid
    click_on "Update Cargapp payment"

    assert_text "Cargapp payment was successfully updated"
    click_on "Back"
  end

  test "destroying a Cargapp payment" do
    visit cargapp_payments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cargapp payment was successfully destroyed"
  end
end
