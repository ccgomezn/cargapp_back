require 'test_helper'

class FavoriteRoutesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @favorite_route = favorite_routes(:one)
  end

  test "should get index" do
    get favorite_routes_url
    assert_response :success
  end

  test "should get new" do
    get new_favorite_route_url
    assert_response :success
  end

  test "should create favorite_route" do
    assert_difference('FavoriteRoute.count') do
      post favorite_routes_url, params: { favorite_route: { active: @favorite_route.active, destination_city_id: @favorite_route.destination_city_id, origin_city_id: @favorite_route.origin_city_id, user_id: @favorite_route.user_id } }
    end

    assert_redirected_to favorite_route_url(FavoriteRoute.last)
  end

  test "should show favorite_route" do
    get favorite_route_url(@favorite_route)
    assert_response :success
  end

  test "should get edit" do
    get edit_favorite_route_url(@favorite_route)
    assert_response :success
  end

  test "should update favorite_route" do
    patch favorite_route_url(@favorite_route), params: { favorite_route: { active: @favorite_route.active, destination_city_id: @favorite_route.destination_city_id, origin_city_id: @favorite_route.origin_city_id, user_id: @favorite_route.user_id } }
    assert_redirected_to favorite_route_url(@favorite_route)
  end

  test "should destroy favorite_route" do
    assert_difference('FavoriteRoute.count', -1) do
      delete favorite_route_url(@favorite_route)
    end

    assert_redirected_to favorite_routes_url
  end
end
