require 'test_helper'

class CargappAdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cargapp_ad = cargapp_ads(:one)
  end

  test "should get index" do
    get cargapp_ads_url
    assert_response :success
  end

  test "should get new" do
    get new_cargapp_ad_url
    assert_response :success
  end

  test "should create cargapp_ad" do
    assert_difference('CargappAd.count') do
      post cargapp_ads_url, params: { cargapp_ad: { active: @cargapp_ad.active, body: @cargapp_ad.body, description: @cargapp_ad.description, discoun: @cargapp_ad.discoun, have_discoun: @cargapp_ad.have_discoun, image: @cargapp_ad.image, is_percentage: @cargapp_ad.is_percentage, media: @cargapp_ad.media, name: @cargapp_ad.name, price: @cargapp_ad.price, url: @cargapp_ad.url, user_id: @cargapp_ad.user_id } }
    end

    assert_redirected_to cargapp_ad_url(CargappAd.last)
  end

  test "should show cargapp_ad" do
    get cargapp_ad_url(@cargapp_ad)
    assert_response :success
  end

  test "should get edit" do
    get edit_cargapp_ad_url(@cargapp_ad)
    assert_response :success
  end

  test "should update cargapp_ad" do
    patch cargapp_ad_url(@cargapp_ad), params: { cargapp_ad: { active: @cargapp_ad.active, body: @cargapp_ad.body, description: @cargapp_ad.description, discoun: @cargapp_ad.discoun, have_discoun: @cargapp_ad.have_discoun, image: @cargapp_ad.image, is_percentage: @cargapp_ad.is_percentage, media: @cargapp_ad.media, name: @cargapp_ad.name, price: @cargapp_ad.price, url: @cargapp_ad.url, user_id: @cargapp_ad.user_id } }
    assert_redirected_to cargapp_ad_url(@cargapp_ad)
  end

  test "should destroy cargapp_ad" do
    assert_difference('CargappAd.count', -1) do
      delete cargapp_ad_url(@cargapp_ad)
    end

    assert_redirected_to cargapp_ads_url
  end
end
