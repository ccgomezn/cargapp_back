require 'test_helper'

class CompanyUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company_user = company_users(:one)
  end

  test "should get index" do
    get company_users_url
    assert_response :success
  end

  test "should get new" do
    get new_company_user_url
    assert_response :success
  end

  test "should create company_user" do
    assert_difference('CompanyUser.count') do
      post company_users_url, params: { company_user: { active: @company_user.active, company_id: @company_user.company_id, user_id: @company_user.user_id } }
    end

    assert_redirected_to company_user_url(CompanyUser.last)
  end

  test "should show company_user" do
    get company_user_url(@company_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_company_user_url(@company_user)
    assert_response :success
  end

  test "should update company_user" do
    patch company_user_url(@company_user), params: { company_user: { active: @company_user.active, company_id: @company_user.company_id, user_id: @company_user.user_id } }
    assert_redirected_to company_user_url(@company_user)
  end

  test "should destroy company_user" do
    assert_difference('CompanyUser.count', -1) do
      delete company_user_url(@company_user)
    end

    assert_redirected_to company_users_url
  end
end
