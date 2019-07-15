require "application_system_test_case"

class CargappModelsTest < ApplicationSystemTestCase
  setup do
    @cargapp_model = cargapp_models(:one)
  end

  test "visiting the index" do
    visit cargapp_models_url
    assert_selector "h1", text: "Cargapp Models"
  end

  test "creating a Cargapp model" do
    visit cargapp_models_url
    click_on "New Cargapp Model"

    check "Active" if @cargapp_model.active
    fill_in "Code", with: @cargapp_model.code
    fill_in "Description", with: @cargapp_model.description
    fill_in "Name", with: @cargapp_model.name
    fill_in "Value", with: @cargapp_model.value
    click_on "Create Cargapp model"

    assert_text "Cargapp model was successfully created"
    click_on "Back"
  end

  test "updating a Cargapp model" do
    visit cargapp_models_url
    click_on "Edit", match: :first

    check "Active" if @cargapp_model.active
    fill_in "Code", with: @cargapp_model.code
    fill_in "Description", with: @cargapp_model.description
    fill_in "Name", with: @cargapp_model.name
    fill_in "Value", with: @cargapp_model.value
    click_on "Update Cargapp model"

    assert_text "Cargapp model was successfully updated"
    click_on "Back"
  end

  test "destroying a Cargapp model" do
    visit cargapp_models_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cargapp model was successfully destroyed"
  end
end
