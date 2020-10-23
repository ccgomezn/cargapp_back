require "application_system_test_case"

class UserPrizesTest < ApplicationSystemTestCase
  setup do
    @user_prize = user_prizes(:one)
  end

  test "visiting the index" do
    visit user_prizes_url
    assert_selector "h1", text: "User Prizes"
  end

  test "creating a User prize" do
    visit user_prizes_url
    click_on "New User Prize"

    check "Active" if @user_prize.active
    fill_in "Expire date", with: @user_prize.expire_date
    fill_in "Point", with: @user_prize.point
    fill_in "Prize", with: @user_prize.prize_id
    fill_in "User", with: @user_prize.user_id
    click_on "Create User prize"

    assert_text "User prize was successfully created"
    click_on "Back"
  end

  test "updating a User prize" do
    visit user_prizes_url
    click_on "Edit", match: :first

    check "Active" if @user_prize.active
    fill_in "Expire date", with: @user_prize.expire_date
    fill_in "Point", with: @user_prize.point
    fill_in "Prize", with: @user_prize.prize_id
    fill_in "User", with: @user_prize.user_id
    click_on "Update User prize"

    assert_text "User prize was successfully updated"
    click_on "Back"
  end

  test "destroying a User prize" do
    visit user_prizes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User prize was successfully destroyed"
  end
end
