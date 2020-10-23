require "application_system_test_case"

class CountriesTest < ApplicationSystemTestCase
  setup do
    @country = countries(:one)
  end

  test "visiting the index" do
    visit countries_url
    assert_selector "h1", text: "Countries"
  end

  test "creating a Country" do
    visit countries_url
    click_on "New Country"

    check "Active" if @country.active
    fill_in "Cioc", with: @country.cioc
    fill_in "Code", with: @country.code
    fill_in "Currency code", with: @country.currency_code
    fill_in "Currency name", with: @country.currency_name
    fill_in "Currency symbol", with: @country.currency_symbol
    fill_in "Date utc", with: @country.date_utc
    fill_in "Description", with: @country.description
    fill_in "Image", with: @country.image
    fill_in "Language iso639", with: @country.language_iso639
    fill_in "Language name", with: @country.language_name
    fill_in "Language native name", with: @country.language_native_name
    fill_in "Name", with: @country.name
    click_on "Create Country"

    assert_text "Country was successfully created"
    click_on "Back"
  end

  test "updating a Country" do
    visit countries_url
    click_on "Edit", match: :first

    check "Active" if @country.active
    fill_in "Cioc", with: @country.cioc
    fill_in "Code", with: @country.code
    fill_in "Currency code", with: @country.currency_code
    fill_in "Currency name", with: @country.currency_name
    fill_in "Currency symbol", with: @country.currency_symbol
    fill_in "Date utc", with: @country.date_utc
    fill_in "Description", with: @country.description
    fill_in "Image", with: @country.image
    fill_in "Language iso639", with: @country.language_iso639
    fill_in "Language name", with: @country.language_name
    fill_in "Language native name", with: @country.language_native_name
    fill_in "Name", with: @country.name
    click_on "Update Country"

    assert_text "Country was successfully updated"
    click_on "Back"
  end

  test "destroying a Country" do
    visit countries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Country was successfully destroyed"
  end
end
