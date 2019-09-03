require "application_system_test_case"

class PaymentsTest < ApplicationSystemTestCase
  setup do
    @payment = payments(:one)
  end

  test "visiting the index" do
    visit payments_url
    assert_selector "h1", text: "Payments"
  end

  test "creating a Payment" do
    visit payments_url
    click_on "New Payment"

    check "Active" if @payment.active
    fill_in "Coupon amount", with: @payment.coupon_amount
    fill_in "Coupon code", with: @payment.coupon_code
    fill_in "Coupon", with: @payment.coupon_id
    check "Is service" if @payment.is_service
    fill_in "Observation", with: @payment.observation
    fill_in "Payment method", with: @payment.payment_method_id
    fill_in "Service", with: @payment.service_id
    fill_in "Statu", with: @payment.statu_id
    fill_in "Sub total", with: @payment.sub_total
    fill_in "Taxes", with: @payment.taxes
    fill_in "Total", with: @payment.total
    fill_in "Transaction code", with: @payment.transaction_code
    fill_in "User", with: @payment.user_id
    fill_in "User payment method", with: @payment.user_payment_method_id
    fill_in "Uuid", with: @payment.uuid
    click_on "Create Payment"

    assert_text "Payment was successfully created"
    click_on "Back"
  end

  test "updating a Payment" do
    visit payments_url
    click_on "Edit", match: :first

    check "Active" if @payment.active
    fill_in "Coupon amount", with: @payment.coupon_amount
    fill_in "Coupon code", with: @payment.coupon_code
    fill_in "Coupon", with: @payment.coupon_id
    check "Is service" if @payment.is_service
    fill_in "Observation", with: @payment.observation
    fill_in "Payment method", with: @payment.payment_method_id
    fill_in "Service", with: @payment.service_id
    fill_in "Statu", with: @payment.statu_id
    fill_in "Sub total", with: @payment.sub_total
    fill_in "Taxes", with: @payment.taxes
    fill_in "Total", with: @payment.total
    fill_in "Transaction code", with: @payment.transaction_code
    fill_in "User", with: @payment.user_id
    fill_in "User payment method", with: @payment.user_payment_method_id
    fill_in "Uuid", with: @payment.uuid
    click_on "Update Payment"

    assert_text "Payment was successfully updated"
    click_on "Back"
  end

  test "destroying a Payment" do
    visit payments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Payment was successfully destroyed"
  end
end
