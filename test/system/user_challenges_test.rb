require "application_system_test_case"

class UserChallengesTest < ApplicationSystemTestCase
  setup do
    @user_challenge = user_challenges(:one)
  end

  test "visiting the index" do
    visit user_challenges_url
    assert_selector "h1", text: "User Challenges"
  end

  test "creating a User challenge" do
    visit user_challenges_url
    click_on "New User Challenge"

    check "Active" if @user_challenge.active
    fill_in "Challenge", with: @user_challenge.challenge_id
    fill_in "Point", with: @user_challenge.point
    fill_in "Position", with: @user_challenge.position
    fill_in "User", with: @user_challenge.user_id
    click_on "Create User challenge"

    assert_text "User challenge was successfully created"
    click_on "Back"
  end

  test "updating a User challenge" do
    visit user_challenges_url
    click_on "Edit", match: :first

    check "Active" if @user_challenge.active
    fill_in "Challenge", with: @user_challenge.challenge_id
    fill_in "Point", with: @user_challenge.point
    fill_in "Position", with: @user_challenge.position
    fill_in "User", with: @user_challenge.user_id
    click_on "Update User challenge"

    assert_text "User challenge was successfully updated"
    click_on "Back"
  end

  test "destroying a User challenge" do
    visit user_challenges_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User challenge was successfully destroyed"
  end
end
