require "application_system_test_case"

class CitiesTest < ApplicationSystemTestCase
  setup do
    @city = cities(:one)
  end

  test "visiting the index" do
    visit cities_url
    assert_selector "h1", text: "Cities"
  end

  test "creating a City" do
    visit cities_url
    click_on "New City"

    check "Active" if @city.active
    fill_in "Code", with: @city.code
    fill_in "Description", with: @city.description
    fill_in "Name", with: @city.name
    fill_in "State", with: @city.state_id
    click_on "Create City"

    assert_text "City was successfully created"
    click_on "Back"
  end

  test "updating a City" do
    visit cities_url
    click_on "Edit", match: :first

    check "Active" if @city.active
    fill_in "Code", with: @city.code
    fill_in "Description", with: @city.description
    fill_in "Name", with: @city.name
    fill_in "State", with: @city.state_id
    click_on "Update City"

    assert_text "City was successfully updated"
    click_on "Back"
  end

  test "destroying a City" do
    visit cities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "City was successfully destroyed"
  end
end
