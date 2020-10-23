require "application_system_test_case"

class CargappIntegrationsTest < ApplicationSystemTestCase
  setup do
    @cargapp_integration = cargapp_integrations(:one)
  end

  test "visiting the index" do
    visit cargapp_integrations_url
    assert_selector "h1", text: "Cargapp Integrations"
  end

  test "creating a Cargapp integration" do
    visit cargapp_integrations_url
    click_on "New Cargapp Integration"

    check "Active" if @cargapp_integration.active
    fill_in "Api key", with: @cargapp_integration.api_key
    fill_in "App", with: @cargapp_integration.app_id
    fill_in "Client", with: @cargapp_integration.client_id
    fill_in "Code", with: @cargapp_integration.code
    fill_in "Description", with: @cargapp_integration.description
    fill_in "Email", with: @cargapp_integration.email
    fill_in "Name", with: @cargapp_integration.name
    fill_in "Password", with: @cargapp_integration.password
    fill_in "Phone", with: @cargapp_integration.phone
    fill_in "Pin", with: @cargapp_integration.pin
    fill_in "Provider", with: @cargapp_integration.provider
    fill_in "Token", with: @cargapp_integration.token
    fill_in "Url", with: @cargapp_integration.url
    fill_in "Url develop", with: @cargapp_integration.url_develop
    fill_in "Url production", with: @cargapp_integration.url_production
    fill_in "Url provider", with: @cargapp_integration.url_provider
    fill_in "User", with: @cargapp_integration.user_id
    fill_in "Username", with: @cargapp_integration.username
    click_on "Create Cargapp integration"

    assert_text "Cargapp integration was successfully created"
    click_on "Back"
  end

  test "updating a Cargapp integration" do
    visit cargapp_integrations_url
    click_on "Edit", match: :first

    check "Active" if @cargapp_integration.active
    fill_in "Api key", with: @cargapp_integration.api_key
    fill_in "App", with: @cargapp_integration.app_id
    fill_in "Client", with: @cargapp_integration.client_id
    fill_in "Code", with: @cargapp_integration.code
    fill_in "Description", with: @cargapp_integration.description
    fill_in "Email", with: @cargapp_integration.email
    fill_in "Name", with: @cargapp_integration.name
    fill_in "Password", with: @cargapp_integration.password
    fill_in "Phone", with: @cargapp_integration.phone
    fill_in "Pin", with: @cargapp_integration.pin
    fill_in "Provider", with: @cargapp_integration.provider
    fill_in "Token", with: @cargapp_integration.token
    fill_in "Url", with: @cargapp_integration.url
    fill_in "Url develop", with: @cargapp_integration.url_develop
    fill_in "Url production", with: @cargapp_integration.url_production
    fill_in "Url provider", with: @cargapp_integration.url_provider
    fill_in "User", with: @cargapp_integration.user_id
    fill_in "Username", with: @cargapp_integration.username
    click_on "Update Cargapp integration"

    assert_text "Cargapp integration was successfully updated"
    click_on "Back"
  end

  test "destroying a Cargapp integration" do
    visit cargapp_integrations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cargapp integration was successfully destroyed"
  end
end
