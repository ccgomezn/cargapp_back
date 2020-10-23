require 'test_helper'

class VehicleBankAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vehicle_bank_account = vehicle_bank_accounts(:one)
  end

  test "should get index" do
    get vehicle_bank_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_vehicle_bank_account_url
    assert_response :success
  end

  test "should create vehicle_bank_account" do
    assert_difference('VehicleBankAccount.count') do
      post vehicle_bank_accounts_url, params: { vehicle_bank_account: { account_number: @vehicle_bank_account.account_number, account_type: @vehicle_bank_account.account_type, active: @vehicle_bank_account.active, approved: @vehicle_bank_account.approved, bank: @vehicle_bank_account.bank, certificate: @vehicle_bank_account.certificate, statu_id: @vehicle_bank_account.statu_id, user_id: @vehicle_bank_account.user_id, vehicle_id: @vehicle_bank_account.vehicle_id } }
    end

    assert_redirected_to vehicle_bank_account_url(VehicleBankAccount.last)
  end

  test "should show vehicle_bank_account" do
    get vehicle_bank_account_url(@vehicle_bank_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_vehicle_bank_account_url(@vehicle_bank_account)
    assert_response :success
  end

  test "should update vehicle_bank_account" do
    patch vehicle_bank_account_url(@vehicle_bank_account), params: { vehicle_bank_account: { account_number: @vehicle_bank_account.account_number, account_type: @vehicle_bank_account.account_type, active: @vehicle_bank_account.active, approved: @vehicle_bank_account.approved, bank: @vehicle_bank_account.bank, certificate: @vehicle_bank_account.certificate, statu_id: @vehicle_bank_account.statu_id, user_id: @vehicle_bank_account.user_id, vehicle_id: @vehicle_bank_account.vehicle_id } }
    assert_redirected_to vehicle_bank_account_url(@vehicle_bank_account)
  end

  test "should destroy vehicle_bank_account" do
    assert_difference('VehicleBankAccount.count', -1) do
      delete vehicle_bank_account_url(@vehicle_bank_account)
    end

    assert_redirected_to vehicle_bank_accounts_url
  end
end
