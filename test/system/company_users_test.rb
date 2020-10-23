require "application_system_test_case"

class CompanyUsersTest < ApplicationSystemTestCase
  setup do
    @company_user = company_users(:one)
  end

  test "visiting the index" do
    visit company_users_url
    assert_selector "h1", text: "Company Users"
  end

  test "creating a Company user" do
    visit company_users_url
    click_on "New Company User"

    check "Active" if @company_user.active
    fill_in "Company", with: @company_user.company_id
    fill_in "User", with: @company_user.user_id
    click_on "Create Company user"

    assert_text "Company user was successfully created"
    click_on "Back"
  end

  test "updating a Company user" do
    visit company_users_url
    click_on "Edit", match: :first

    check "Active" if @company_user.active
    fill_in "Company", with: @company_user.company_id
    fill_in "User", with: @company_user.user_id
    click_on "Update Company user"

    assert_text "Company user was successfully updated"
    click_on "Back"
  end

  test "destroying a Company user" do
    visit company_users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Company user was successfully destroyed"
  end
end
