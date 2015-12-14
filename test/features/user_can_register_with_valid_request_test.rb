require_relative '../test_helper'
require_relative '../simulation_environment/test_data.rb'

class UserCanRegisterWithValidRequestTest < FeatureTest

  def test_user_can_register_with_valid_request
      visit "/"
      assert_equal "/", current_path
      within("#main_page_heading") do
        assert page.has_content?("Traffic Spy")
      end

      `curl -i -d 'identifier=ultratest&rootUrl=http://ultratest.com' http://localhost:9393/sources`
      `curl -i -d 'payload={
                            "url":"http://ultratest.com/test",
                            "requestedAt":"2013-01-16 24:38:28 -0700",
                            "respondedIn":540,
                            "referredBy":"http://google.com",
                            "requestType":"POST",
                            "parameters":["what","huh"],
                            "eventName": "socialLogin",
                            "userAgent":"Mozilla/4.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                            "resolutionWidth":"1920",
                            "resolutionHeight":"1080",
                            "ip":"63.29.38.213"
                           }' http://localhost:9393/sources/ultratest/data`
      visit "/sources/ultratest/data"
      assert_equal "/sources/ultratest", current_path


  end

end