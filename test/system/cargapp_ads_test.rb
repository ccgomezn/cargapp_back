require "application_system_test_case"

class CargappAdsTest < ApplicationSystemTestCase
  setup do
    @cargapp_ad = cargapp_ads(:one)
  end

  test "visiting the index" do
    visit cargapp_ads_url
    assert_selector "h1", text: "Cargapp Ads"
  end

  test "creating a Cargapp ad" do
    visit cargapp_ads_url
    click_on "New Cargapp Ad"

    check "Active" if @cargapp_ad.active
    fill_in "Body", with: @cargapp_ad.body
    fill_in "Description", with: @cargapp_ad.description
    fill_in "Discoun", with: @cargapp_ad.discoun
    check "Have discoun" if @cargapp_ad.have_discoun
    fill_in "Image", with: @cargapp_ad.image
    check "Is percentage" if @cargapp_ad.is_percentage
    fill_in "Media", with: @cargapp_ad.media
    fill_in "Name", with: @cargapp_ad.name
    fill_in "Price", with: @cargapp_ad.price
    fill_in "Url", with: @cargapp_ad.url
    fill_in "User", with: @cargapp_ad.user_id
    click_on "Create Cargapp ad"

    assert_text "Cargapp ad was successfully created"
    click_on "Back"
  end

  test "updating a Cargapp ad" do
    visit cargapp_ads_url
    click_on "Edit", match: :first

    check "Active" if @cargapp_ad.active
    fill_in "Body", with: @cargapp_ad.body
    fill_in "Description", with: @cargapp_ad.description
    fill_in "Discoun", with: @cargapp_ad.discoun
    check "Have discoun" if @cargapp_ad.have_discoun
    fill_in "Image", with: @cargapp_ad.image
    check "Is percentage" if @cargapp_ad.is_percentage
    fill_in "Media", with: @cargapp_ad.media
    fill_in "Name", with: @cargapp_ad.name
    fill_in "Price", with: @cargapp_ad.price
    fill_in "Url", with: @cargapp_ad.url
    fill_in "User", with: @cargapp_ad.user_id
    click_on "Update Cargapp ad"

    assert_text "Cargapp ad was successfully updated"
    click_on "Back"
  end

  test "destroying a Cargapp ad" do
    visit cargapp_ads_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cargapp ad was successfully destroyed"
  end
end
