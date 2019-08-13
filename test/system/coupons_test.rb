require "application_system_test_case"

class CouponsTest < ApplicationSystemTestCase
  setup do
    @coupon = coupons(:one)
  end

  test "visiting the index" do
    visit coupons_url
    assert_selector "h1", text: "Coupons"
  end

  test "creating a Coupon" do
    visit coupons_url
    click_on "New Coupon"

    check "Active" if @coupon.active
    fill_in "Cargapp model", with: @coupon.cargapp_model_id
    fill_in "Code", with: @coupon.code
    fill_in "Description", with: @coupon.description
    check "Is porcentage" if @coupon.is_porcentage
    fill_in "Name", with: @coupon.name
    fill_in "Quantity", with: @coupon.quantity
    fill_in "User", with: @coupon.user_id
    fill_in "Value", with: @coupon.value
    click_on "Create Coupon"

    assert_text "Coupon was successfully created"
    click_on "Back"
  end

  test "updating a Coupon" do
    visit coupons_url
    click_on "Edit", match: :first

    check "Active" if @coupon.active
    fill_in "Cargapp model", with: @coupon.cargapp_model_id
    fill_in "Code", with: @coupon.code
    fill_in "Description", with: @coupon.description
    check "Is porcentage" if @coupon.is_porcentage
    fill_in "Name", with: @coupon.name
    fill_in "Quantity", with: @coupon.quantity
    fill_in "User", with: @coupon.user_id
    fill_in "Value", with: @coupon.value
    click_on "Update Coupon"

    assert_text "Coupon was successfully updated"
    click_on "Back"
  end

  test "destroying a Coupon" do
    visit coupons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Coupon was successfully destroyed"
  end
end
