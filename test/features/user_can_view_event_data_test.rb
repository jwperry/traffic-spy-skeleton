require_relative '../test_helper'

class UserCanViewEventDataTest < FeatureTest

  def setup
    post '/sources', "identifier=ultratest&rootUrl=http://ultratest.com"

    payload_data = {"url": "http://ultratest.com/tester",
                    "requestedAt": "2015-11-23 11:23:15 -0700",
                    "respondedIn": 100,
                    "referredBy": "http://google.com",
                    "requestType": "POST",
                    "parameters": [],
                    "eventName": "socialLogin",
                    "userAgent": "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                    "resolutionWidth": 1920,
                    "resolutionHeight": 1080,
                    "ip": "126.127.128"}.to_json

                    post "/sources/ultratest/data", {payload: payload_data}
  end

  def test_user_can_view_event_data_test_happy_path
      visit "/"
      assert_equal "/", current_path
      within("#main_page_heading") do
        assert page.has_content?("Traffic Spy")
      end

      visit "/sources/ultratest/events/socialLogin"
      assert_equal "/sources/ultratest/events/socialLogin", current_path
      within("#event_name") do
        assert page.has_content?("socialLogin")
      end
      within("#event_count") do
        assert page.has_content?(1)
      end
  end

  def test_user_can_view_event_data_test_sad_path
      visit "/sources/ultratest/events/not_real"
      within("#event_error") do
        assert page.has_content?("Application Event Details Error")
        assert page.has_content?('There is no "not_real" event.')
      end

      click_link("Back to Event Index for ultratest")
      assert "/sources/ultratest/events", current_path
  end

end
