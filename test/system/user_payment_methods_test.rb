require "application_system_test_case"

class UserPaymentMethodsTest < ApplicationSystemTestCase
  setup do
    @user_payment_method = user_payment_methods(:one)
  end

  test "visiting the index" do
    visit user_payment_methods_url
    assert_selector "h1", text: "User Payment Methods"
  end

  test "creating a User payment method" do
    visit user_payment_methods_url
    click_on "New User Payment Method"

    check "Active" if @user_payment_method.active
    fill_in "Card number", with: @user_payment_method.card_number
    fill_in "Cvv", with: @user_payment_method.cvv
    fill_in "Email", with: @user_payment_method.email
    fill_in "Expiration", with: @user_payment_method.expiration
    fill_in "Observation", with: @user_payment_method.observation
    fill_in "Payment method", with: @user_payment_method.payment_method_id
    fill_in "Token", with: @user_payment_method.token
    fill_in "User", with: @user_payment_method.user_id
    fill_in "Uuid", with: @user_payment_method.uuid
    click_on "Create User payment method"

    assert_text "User payment method was successfully created"
    click_on "Back"
  end

  test "updating a User payment method" do
    visit user_payment_methods_url
    click_on "Edit", match: :first

    check "Active" if @user_payment_method.active
    fill_in "Card number", with: @user_payment_method.card_number
    fill_in "Cvv", with: @user_payment_method.cvv
    fill_in "Email", with: @user_payment_method.email
    fill_in "Expiration", with: @user_payment_method.expiration
    fill_in "Observation", with: @user_payment_method.observation
    fill_in "Payment method", with: @user_payment_method.payment_method_id
    fill_in "Token", with: @user_payment_method.token
    fill_in "User", with: @user_payment_method.user_id
    fill_in "Uuid", with: @user_payment_method.uuid
    click_on "Update User payment method"

    assert_text "User payment method was successfully updated"
    click_on "Back"
  end

  test "destroying a User payment method" do
    visit user_payment_methods_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User payment method was successfully destroyed"
  end
end
