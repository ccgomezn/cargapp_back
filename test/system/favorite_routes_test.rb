require "application_system_test_case"

class FavoriteRoutesTest < ApplicationSystemTestCase
  setup do
    @favorite_route = favorite_routes(:one)
  end

  test "visiting the index" do
    visit favorite_routes_url
    assert_selector "h1", text: "Favorite Routes"
  end

  test "creating a Favorite route" do
    visit favorite_routes_url
    click_on "New Favorite Route"

    check "Active" if @favorite_route.active
    fill_in "Destination city", with: @favorite_route.destination_city_id
    fill_in "Origin city", with: @favorite_route.origin_city_id
    fill_in "User", with: @favorite_route.user_id
    click_on "Create Favorite route"

    assert_text "Favorite route was successfully created"
    click_on "Back"
  end

  test "updating a Favorite route" do
    visit favorite_routes_url
    click_on "Edit", match: :first

    check "Active" if @favorite_route.active
    fill_in "Destination city", with: @favorite_route.destination_city_id
    fill_in "Origin city", with: @favorite_route.origin_city_id
    fill_in "User", with: @favorite_route.user_id
    click_on "Update Favorite route"

    assert_text "Favorite route was successfully updated"
    click_on "Back"
  end

  test "destroying a Favorite route" do
    visit favorite_routes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Favorite route was successfully destroyed"
  end
end
