require 'test_helper'

class CargappIntegrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cargapp_integration = cargapp_integrations(:one)
  end

  test "should get index" do
    get cargapp_integrations_url
    assert_response :success
  end

  test "should get new" do
    get new_cargapp_integration_url
    assert_response :success
  end

  test "should create cargapp_integration" do
    assert_difference('CargappIntegration.count') do
      post cargapp_integrations_url, params: { cargapp_integration: { active: @cargapp_integration.active, api_key: @cargapp_integration.api_key, app_id: @cargapp_integration.app_id, client_id: @cargapp_integration.client_id, code: @cargapp_integration.code, description: @cargapp_integration.description, email: @cargapp_integration.email, name: @cargapp_integration.name, password: @cargapp_integration.password, phone: @cargapp_integration.phone, pin: @cargapp_integration.pin, provider: @cargapp_integration.provider, token: @cargapp_integration.token, url: @cargapp_integration.url, url_develop: @cargapp_integration.url_develop, url_production: @cargapp_integration.url_production, url_provider: @cargapp_integration.url_provider, user_id: @cargapp_integration.user_id, username: @cargapp_integration.username } }
    end

    assert_redirected_to cargapp_integration_url(CargappIntegration.last)
  end

  test "should show cargapp_integration" do
    get cargapp_integration_url(@cargapp_integration)
    assert_response :success
  end

  test "should get edit" do
    get edit_cargapp_integration_url(@cargapp_integration)
    assert_response :success
  end

  test "should update cargapp_integration" do
    patch cargapp_integration_url(@cargapp_integration), params: { cargapp_integration: { active: @cargapp_integration.active, api_key: @cargapp_integration.api_key, app_id: @cargapp_integration.app_id, client_id: @cargapp_integration.client_id, code: @cargapp_integration.code, description: @cargapp_integration.description, email: @cargapp_integration.email, name: @cargapp_integration.name, password: @cargapp_integration.password, phone: @cargapp_integration.phone, pin: @cargapp_integration.pin, provider: @cargapp_integration.provider, token: @cargapp_integration.token, url: @cargapp_integration.url, url_develop: @cargapp_integration.url_develop, url_production: @cargapp_integration.url_production, url_provider: @cargapp_integration.url_provider, user_id: @cargapp_integration.user_id, username: @cargapp_integration.username } }
    assert_redirected_to cargapp_integration_url(@cargapp_integration)
  end

  test "should destroy cargapp_integration" do
    assert_difference('CargappIntegration.count', -1) do
      delete cargapp_integration_url(@cargapp_integration)
    end

    assert_redirected_to cargapp_integrations_url
  end
end
