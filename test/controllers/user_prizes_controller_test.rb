require 'test_helper'

class UserPrizesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_prize = user_prizes(:one)
  end

  test "should get index" do
    get user_prizes_url
    assert_response :success
  end

  test "should get new" do
    get new_user_prize_url
    assert_response :success
  end

  test "should create user_prize" do
    assert_difference('UserPrize.count') do
      post user_prizes_url, params: { user_prize: { active: @user_prize.active, expire_date: @user_prize.expire_date, point: @user_prize.point, prize_id: @user_prize.prize_id, user_id: @user_prize.user_id } }
    end

    assert_redirected_to user_prize_url(UserPrize.last)
  end

  test "should show user_prize" do
    get user_prize_url(@user_prize)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_prize_url(@user_prize)
    assert_response :success
  end

  test "should update user_prize" do
    patch user_prize_url(@user_prize), params: { user_prize: { active: @user_prize.active, expire_date: @user_prize.expire_date, point: @user_prize.point, prize_id: @user_prize.prize_id, user_id: @user_prize.user_id } }
    assert_redirected_to user_prize_url(@user_prize)
  end

  test "should destroy user_prize" do
    assert_difference('UserPrize.count', -1) do
      delete user_prize_url(@user_prize)
    end

    assert_redirected_to user_prizes_url
  end
end
