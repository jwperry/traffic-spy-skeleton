require_relative '../test_helper'

class UserCanViewDataForIdentifierTest < FeatureTest

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

  def test_user_can_register_with_valid_request
      visit "/"
      assert_equal "/", current_path
      within("#main_page_heading") do
        assert page.has_content?("Traffic Spy")
      end

      visit "/sources/ultratest"
      assert_equal "/sources/ultratest", current_path
      within("#app_details_main") do
        assert page.has_content?("ultratest")
        assert page.has_content?("tester : 1")
        assert page.has_content?("Mac OS X 10.8.2")
        assert page.has_content?("Chrome 24.0.1309")
        assert page.has_content?("Longest Average Response Time: 100.0")
        assert page.has_content?("Shortest Average Response Time: 100.0")
        assert page.has_content?("Screen Resolutions: 1920 by 1080")
      end
  end

end