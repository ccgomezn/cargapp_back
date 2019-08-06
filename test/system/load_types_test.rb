require "application_system_test_case"

class LoadTypesTest < ApplicationSystemTestCase
  setup do
    @load_type = load_types(:one)
  end

  test "visiting the index" do
    visit load_types_url
    assert_selector "h1", text: "Load Types"
  end

  test "creating a Load type" do
    visit load_types_url
    click_on "New Load Type"

    check "Active" if @load_type.active
    fill_in "Code", with: @load_type.code
    fill_in "Description", with: @load_type.description
    fill_in "Icon", with: @load_type.icon
    fill_in "Name", with: @load_type.name
    click_on "Create Load type"

    assert_text "Load type was successfully created"
    click_on "Back"
  end

  test "updating a Load type" do
    visit load_types_url
    click_on "Edit", match: :first

    check "Active" if @load_type.active
    fill_in "Code", with: @load_type.code
    fill_in "Description", with: @load_type.description
    fill_in "Icon", with: @load_type.icon
    fill_in "Name", with: @load_type.name
    click_on "Update Load type"

    assert_text "Load type was successfully updated"
    click_on "Back"
  end

  test "destroying a Load type" do
    visit load_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Load type was successfully destroyed"
  end
end
