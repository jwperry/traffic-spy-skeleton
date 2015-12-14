require_relative '../test_helper'

class CreateApplicationTest < ControllerTestSetup

  def setup
    @payload_data = { "url":"http://jumpstartlab.com/blog",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn":37,
                "referredBy":"http://jumpstartlab.com",
                "requestType":"GET",
                "parameters":[],
                "eventName":"socialLogin",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"63.29.38.211"
              }.to_json
  end

  def test_can_access_url_specific_data_page
    Application.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    post '/sources/jumpstartlab/data', {payload: @payload_data}
    get '/sources/jumpstartlab/events/socialLogin'
    assert_equal :event_data, last_response.status
  end

end
