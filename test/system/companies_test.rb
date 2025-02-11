require "application_system_test_case"

class CompaniesTest < ApplicationSystemTestCase
  setup do
    @company = companies(:one)
  end

  test "visiting the index" do
    visit companies_url
    assert_selector "h1", text: "Companies"
  end

  test "creating a Company" do
    visit companies_url
    click_on "New Company"

    check "Active" if @company.active
    fill_in "Address", with: @company.address
    fill_in "Company type", with: @company.company_type
    fill_in "Constitution date", with: @company.constitution_date
    fill_in "Description", with: @company.description
    fill_in "Legal representative", with: @company.legal_representative
    fill_in "Load type", with: @company.load_type_id
    fill_in "Name", with: @company.name
    fill_in "Phone", with: @company.phone
    fill_in "Sector", with: @company.sector
    fill_in "User", with: @company.user_id
    click_on "Create Company"

    assert_text "Company was successfully created"
    click_on "Back"
  end

  test "updating a Company" do
    visit companies_url
    click_on "Edit", match: :first

    check "Active" if @company.active
    fill_in "Address", with: @company.address
    fill_in "Company type", with: @company.company_type
    fill_in "Constitution date", with: @company.constitution_date
    fill_in "Description", with: @company.description
    fill_in "Legal representative", with: @company.legal_representative
    fill_in "Load type", with: @company.load_type_id
    fill_in "Name", with: @company.name
    fill_in "Phone", with: @company.phone
    fill_in "Sector", with: @company.sector
    fill_in "User", with: @company.user_id
    click_on "Update Company"

    assert_text "Company was successfully updated"
    click_on "Back"
  end

  test "destroying a Company" do
    visit companies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Company was successfully destroyed"
  end
end
