require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:one)
  end

  test "visiting the index" do
    visit reports_url
    assert_selector "h1", text: "Reports"
  end

  test "creating a Report" do
    visit reports_url
    click_on "New Report"

    check "Active" if @report.active
    fill_in "Cause", with: @report.cause
    fill_in "Destination", with: @report.destination
    fill_in "End date", with: @report.end_date
    fill_in "Geolocation", with: @report.geolocation
    fill_in "Image", with: @report.image
    fill_in "Name", with: @report.name
    fill_in "Novelty", with: @report.novelty
    fill_in "Origin", with: @report.origin
    fill_in "Report type", with: @report.report_type
    fill_in "Sense", with: @report.sense
    fill_in "Start date", with: @report.start_date
    fill_in "User", with: @report.user_id
    click_on "Create Report"

    assert_text "Report was successfully created"
    click_on "Back"
  end

  test "updating a Report" do
    visit reports_url
    click_on "Edit", match: :first

    check "Active" if @report.active
    fill_in "Cause", with: @report.cause
    fill_in "Destination", with: @report.destination
    fill_in "End date", with: @report.end_date
    fill_in "Geolocation", with: @report.geolocation
    fill_in "Image", with: @report.image
    fill_in "Name", with: @report.name
    fill_in "Novelty", with: @report.novelty
    fill_in "Origin", with: @report.origin
    fill_in "Report type", with: @report.report_type
    fill_in "Sense", with: @report.sense
    fill_in "Start date", with: @report.start_date
    fill_in "User", with: @report.user_id
    click_on "Update Report"

    assert_text "Report was successfully updated"
    click_on "Back"
  end

  test "destroying a Report" do
    visit reports_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Report was successfully destroyed"
  end
end
