require "application_system_test_case"

class PrizesTest < ApplicationSystemTestCase
  setup do
    @prize = prizes(:one)
  end

  test "visiting the index" do
    visit prizes_url
    assert_selector "h1", text: "Prizes"
  end

  test "creating a Prize" do
    visit prizes_url
    click_on "New Prize"

    check "Active" if @prize.active
    fill_in "Body", with: @prize.body
    fill_in "Code", with: @prize.code
    fill_in "Description", with: @prize.description
    fill_in "Expire date", with: @prize.expire_date
    fill_in "Image", with: @prize.image
    fill_in "Media", with: @prize.media
    fill_in "Name", with: @prize.name
    fill_in "Point", with: @prize.point
    fill_in "User", with: @prize.user_id
    click_on "Create Prize"

    assert_text "Prize was successfully created"
    click_on "Back"
  end

  test "updating a Prize" do
    visit prizes_url
    click_on "Edit", match: :first

    check "Active" if @prize.active
    fill_in "Body", with: @prize.body
    fill_in "Code", with: @prize.code
    fill_in "Description", with: @prize.description
    fill_in "Expire date", with: @prize.expire_date
    fill_in "Image", with: @prize.image
    fill_in "Media", with: @prize.media
    fill_in "Name", with: @prize.name
    fill_in "Point", with: @prize.point
    fill_in "User", with: @prize.user_id
    click_on "Update Prize"

    assert_text "Prize was successfully updated"
    click_on "Back"
  end

  test "destroying a Prize" do
    visit prizes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Prize was successfully destroyed"
  end
end
