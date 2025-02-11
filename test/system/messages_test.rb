require "application_system_test_case"

class MessagesTest < ApplicationSystemTestCase
  setup do
    @message = messages(:one)
  end

  test "visiting the index" do
    visit messages_url
    assert_selector "h1", text: "Messages"
  end

  test "creating a Message" do
    visit messages_url
    click_on "New Message"

    check "Active" if @message.active
    fill_in "File", with: @message.file
    fill_in "Message", with: @message.message
    fill_in "Message type", with: @message.message_type
    fill_in "Room", with: @message.room_id
    fill_in "User", with: @message.user_id
    fill_in "Uuid", with: @message.uuid
    click_on "Create Message"

    assert_text "Message was successfully created"
    click_on "Back"
  end

  test "updating a Message" do
    visit messages_url
    click_on "Edit", match: :first

    check "Active" if @message.active
    fill_in "File", with: @message.file
    fill_in "Message", with: @message.message
    fill_in "Message type", with: @message.message_type
    fill_in "Room", with: @message.room_id
    fill_in "User", with: @message.user_id
    fill_in "Uuid", with: @message.uuid
    click_on "Update Message"

    assert_text "Message was successfully updated"
    click_on "Back"
  end

  test "destroying a Message" do
    visit messages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Message was successfully destroyed"
  end
end
