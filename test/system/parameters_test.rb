require "application_system_test_case"

class ParametersTest < ApplicationSystemTestCase
  setup do
    @parameter = parameters(:one)
  end

  test "visiting the index" do
    visit parameters_url
    assert_selector "h1", text: "Parameters"
  end

  test "creating a Parameter" do
    visit parameters_url
    click_on "New Parameter"

    check "Active" if @parameter.active
    fill_in "Cargapp model", with: @parameter.cargapp_model_id
    fill_in "Code", with: @parameter.code
    fill_in "Description", with: @parameter.description
    fill_in "Name", with: @parameter.name
    fill_in "User", with: @parameter.user_id
    fill_in "Value", with: @parameter.value
    click_on "Create Parameter"

    assert_text "Parameter was successfully created"
    click_on "Back"
  end

  test "updating a Parameter" do
    visit parameters_url
    click_on "Edit", match: :first

    check "Active" if @parameter.active
    fill_in "Cargapp model", with: @parameter.cargapp_model_id
    fill_in "Code", with: @parameter.code
    fill_in "Description", with: @parameter.description
    fill_in "Name", with: @parameter.name
    fill_in "User", with: @parameter.user_id
    fill_in "Value", with: @parameter.value
    click_on "Update Parameter"

    assert_text "Parameter was successfully updated"
    click_on "Back"
  end

  test "destroying a Parameter" do
    visit parameters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Parameter was successfully destroyed"
  end
end
