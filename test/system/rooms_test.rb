require "application_system_test_case"

class RoomsTest < ApplicationSystemTestCase
  setup do
    @room = rooms(:one)
  end

  test "visiting the index" do
    visit rooms_url
    assert_selector "h1", text: "Rooms"
  end

  test "creating a Room" do
    visit rooms_url
    click_on "New Room"

    check "Active" if @room.active
    fill_in "Name", with: @room.name
    fill_in "Note", with: @room.note
    fill_in "Service", with: @room.service_id
    fill_in "User", with: @room.user_id
    click_on "Create Room"

    assert_text "Room was successfully created"
    click_on "Back"
  end

  test "updating a Room" do
    visit rooms_url
    click_on "Edit", match: :first

    check "Active" if @room.active
    fill_in "Name", with: @room.name
    fill_in "Note", with: @room.note
    fill_in "Service", with: @room.service_id
    fill_in "User", with: @room.user_id
    click_on "Update Room"

    assert_text "Room was successfully updated"
    click_on "Back"
  end

  test "destroying a Room" do
    visit rooms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Room was successfully destroyed"
  end
end
