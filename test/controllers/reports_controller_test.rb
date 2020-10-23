require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @report = reports(:one)
  end

  test "should get index" do
    get reports_url
    assert_response :success
  end

  test "should get new" do
    get new_report_url
    assert_response :success
  end

  test "should create report" do
    assert_difference('Report.count') do
      post reports_url, params: { report: { active: @report.active, cause: @report.cause, destination: @report.destination, end_date: @report.end_date, geolocation: @report.geolocation, image: @report.image, name: @report.name, novelty: @report.novelty, origin: @report.origin, report_type: @report.report_type, sense: @report.sense, start_date: @report.start_date, user_id: @report.user_id } }
    end

    assert_redirected_to report_url(Report.last)
  end

  test "should show report" do
    get report_url(@report)
    assert_response :success
  end

  test "should get edit" do
    get edit_report_url(@report)
    assert_response :success
  end

  test "should update report" do
    patch report_url(@report), params: { report: { active: @report.active, cause: @report.cause, destination: @report.destination, end_date: @report.end_date, geolocation: @report.geolocation, image: @report.image, name: @report.name, novelty: @report.novelty, origin: @report.origin, report_type: @report.report_type, sense: @report.sense, start_date: @report.start_date, user_id: @report.user_id } }
    assert_redirected_to report_url(@report)
  end

  test "should destroy report" do
    assert_difference('Report.count', -1) do
      delete report_url(@report)
    end

    assert_redirected_to reports_url
  end
end
