require 'test_helper'

class UserChallengesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_challenge = user_challenges(:one)
  end

  test "should get index" do
    get user_challenges_url
    assert_response :success
  end

  test "should get new" do
    get new_user_challenge_url
    assert_response :success
  end

  test "should create user_challenge" do
    assert_difference('UserChallenge.count') do
      post user_challenges_url, params: { user_challenge: { active: @user_challenge.active, challenge_id: @user_challenge.challenge_id, point: @user_challenge.point, position: @user_challenge.position, user_id: @user_challenge.user_id } }
    end

    assert_redirected_to user_challenge_url(UserChallenge.last)
  end

  test "should show user_challenge" do
    get user_challenge_url(@user_challenge)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_challenge_url(@user_challenge)
    assert_response :success
  end

  test "should update user_challenge" do
    patch user_challenge_url(@user_challenge), params: { user_challenge: { active: @user_challenge.active, challenge_id: @user_challenge.challenge_id, point: @user_challenge.point, position: @user_challenge.position, user_id: @user_challenge.user_id } }
    assert_redirected_to user_challenge_url(@user_challenge)
  end

  test "should destroy user_challenge" do
    assert_difference('UserChallenge.count', -1) do
      delete user_challenge_url(@user_challenge)
    end

    assert_redirected_to user_challenges_url
  end
end
