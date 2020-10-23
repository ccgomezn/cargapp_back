require 'test_helper'

class LoadTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @load_type = load_types(:one)
  end

  test "should get index" do
    get load_types_url
    assert_response :success
  end

  test "should get new" do
    get new_load_type_url
    assert_response :success
  end

  test "should create load_type" do
    assert_difference('LoadType.count') do
      post load_types_url, params: { load_type: { active: @load_type.active, code: @load_type.code, description: @load_type.description, icon: @load_type.icon, name: @load_type.name } }
    end

    assert_redirected_to load_type_url(LoadType.last)
  end

  test "should show load_type" do
    get load_type_url(@load_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_load_type_url(@load_type)
    assert_response :success
  end

  test "should update load_type" do
    patch load_type_url(@load_type), params: { load_type: { active: @load_type.active, code: @load_type.code, description: @load_type.description, icon: @load_type.icon, name: @load_type.name } }
    assert_redirected_to load_type_url(@load_type)
  end

  test "should destroy load_type" do
    assert_difference('LoadType.count', -1) do
      delete load_type_url(@load_type)
    end

    assert_redirected_to load_types_url
  end
end
