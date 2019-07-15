require 'test_helper'

class CargappModelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cargapp_model = cargapp_models(:one)
  end

  test "should get index" do
    get cargapp_models_url
    assert_response :success
  end

  test "should get new" do
    get new_cargapp_model_url
    assert_response :success
  end

  test "should create cargapp_model" do
    assert_difference('CargappModel.count') do
      post cargapp_models_url, params: { cargapp_model: { active: @cargapp_model.active, code: @cargapp_model.code, description: @cargapp_model.description, name: @cargapp_model.name, value: @cargapp_model.value } }
    end

    assert_redirected_to cargapp_model_url(CargappModel.last)
  end

  test "should show cargapp_model" do
    get cargapp_model_url(@cargapp_model)
    assert_response :success
  end

  test "should get edit" do
    get edit_cargapp_model_url(@cargapp_model)
    assert_response :success
  end

  test "should update cargapp_model" do
    patch cargapp_model_url(@cargapp_model), params: { cargapp_model: { active: @cargapp_model.active, code: @cargapp_model.code, description: @cargapp_model.description, name: @cargapp_model.name, value: @cargapp_model.value } }
    assert_redirected_to cargapp_model_url(@cargapp_model)
  end

  test "should destroy cargapp_model" do
    assert_difference('CargappModel.count', -1) do
      delete cargapp_model_url(@cargapp_model)
    end

    assert_redirected_to cargapp_models_url
  end
end
