require_relative '../test_helper'

class UserCanViewDataForPathTest < FeatureTest

  def setup
    post '/sources', "identifier=ultratest&rootUrl=http://ultratest.com"

    payload_data = {"url": "http://ultratest.com/tester",
                    "requestedAt": "2015-11-23 11:23:15 -0700",
                    "respondedIn": 100,
                    "referredBy": "http://google.com",
                    "requestType": "POST",
                    "parameters": [],
                    "eventName": "#socialLogin",
                    "userAgent": "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                    "resolutionWidth": 1920,
                    "resolutionHeight": 1080,
                    "ip": "126.127.128"}.to_json

                    post "/sources/ultratest/data", {payload: payload_data}
  end

  def test_user_can_view_data_for_path_happy_path
      visit "/"
      assert_equal "/", current_path
      within("#main_page_heading") do
        assert page.has_content?("Traffic Spy")
      end

      visit "/sources/ultratest/urls/tester"
      assert_equal "/sources/ultratest/urls/tester", current_path
      within("#path_error") do
        assert page.has_content?("POST")
      end
      within("#path") do
        assert page.has_content?("tester")
      end
  end

  def test_user_can_view_data_for_path_sad_path
      visit "/"
      assert_equal "/", current_path
      within("#main_page_heading") do
        assert page.has_content?("Traffic Spy")
      end

      visit "/sources/ultratest/urls/tster"
      assert_equal "/sources/ultratest/urls/tster", current_path
      save_and_open_page
      within("#path_error") do
        assert page.has_content?("The URL 'tster' has not been requested.")
      end
  end

end
