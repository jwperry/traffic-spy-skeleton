require_relative '../test_helper'

class UserCanViewIdentifierDataByEventTest < FeatureTest

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

  def test_user_can_register_with_valid_request_happy_path
    visit "/sources/ultratest"
    assert_equal "/sources/ultratest", current_path

    click_link('View Events for This User')

    assert_equal "/sources/ultratest/events", current_path

    within("#event_index_main") do
      assert page.has_content?("Application Events Index")
      assert page.has_content?("socialLogin Count: 1")
    end
  end

  def test_user_can_register_with_valid_request_sad_path
    visit '/sources/not_real/events'
    
    within("#identifier_error") do
      assert page.has_content?("Identifier Error")
      assert page.has_content?('There is no identifier called "not_real" for this request.')
    end

    click_link("Back to Search")
    assert "/", current_path
  end

end