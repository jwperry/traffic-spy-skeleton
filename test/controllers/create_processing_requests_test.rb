require_relative '../test_helper'

class CreateProcessingRequestsTest < ControllerTestSetup

  def test_a_post_request_has_a_valid_payload
    skip
    payload = { "url":"http://jumpstartlab.com/blog",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn":37,
                "referredBy":"http://jumpstartlab.com",
                "requestType":"GET",
                "parameters":[],
                "eventName": "socialLogin",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"63.29.38.211"
              }

    post '/sources/jumpstartlab/data', payload

    assert_equal 200, last_response.status
    assert_equal 1, Payload.count

  end

  def test_a_post_request_has_a_valid_payload
    payload_data = { "requestedAt":"2013-02-16 21:38:28 -0700", "respondedIn":37}.to_json
    
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    post '/sources/jumpstartlab/data', {payload: payload_data}

    assert_equal 404, last_response.status
    assert_equal 1, Payload.count
    assert_equal nil, Payload.first[:application_id]
  end

end