require "application_system_test_case"

class VehicleBankAccountsTest < ApplicationSystemTestCase
  setup do
    @vehicle_bank_account = vehicle_bank_accounts(:one)
  end

  test "visiting the index" do
    visit vehicle_bank_accounts_url
    assert_selector "h1", text: "Vehicle Bank Accounts"
  end

  test "creating a Vehicle bank account" do
    visit vehicle_bank_accounts_url
    click_on "New Vehicle Bank Account"

    fill_in "Account number", with: @vehicle_bank_account.account_number
    fill_in "Account type", with: @vehicle_bank_account.account_type
    check "Active" if @vehicle_bank_account.active
    check "Approved" if @vehicle_bank_account.approved
    fill_in "Bank", with: @vehicle_bank_account.bank
    fill_in "Certificate", with: @vehicle_bank_account.certificate
    fill_in "Statu", with: @vehicle_bank_account.statu_id
    fill_in "User", with: @vehicle_bank_account.user_id
    fill_in "Vehicle", with: @vehicle_bank_account.vehicle_id
    click_on "Create Vehicle bank account"

    assert_text "Vehicle bank account was successfully created"
    click_on "Back"
  end

  test "updating a Vehicle bank account" do
    visit vehicle_bank_accounts_url
    click_on "Edit", match: :first

    fill_in "Account number", with: @vehicle_bank_account.account_number
    fill_in "Account type", with: @vehicle_bank_account.account_type
    check "Active" if @vehicle_bank_account.active
    check "Approved" if @vehicle_bank_account.approved
    fill_in "Bank", with: @vehicle_bank_account.bank
    fill_in "Certificate", with: @vehicle_bank_account.certificate
    fill_in "Statu", with: @vehicle_bank_account.statu_id
    fill_in "User", with: @vehicle_bank_account.user_id
    fill_in "Vehicle", with: @vehicle_bank_account.vehicle_id
    click_on "Update Vehicle bank account"

    assert_text "Vehicle bank account was successfully updated"
    click_on "Back"
  end

  test "destroying a Vehicle bank account" do
    visit vehicle_bank_accounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vehicle bank account was successfully destroyed"
  end
end
