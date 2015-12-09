require_relative '../test_helper'

class CreateProcessingRequestsTest < ControllerTestSetup

  def test_a_post_request_has_a_valid_payload
    payload_data = { "url":"http://jumpstartlab.com/blog",
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
              }.to_json

    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'

    post '/sources/jumpstartlab/data', {payload: payload_data}
    assert_equal 200, last_response.status
    assert_equal 1, Payload.count
    assert_equal 1, Payload.first[:application_id]
  end

  def test_returns_400_bad_request_if_payload_missing
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    post '/sources/jumpstartlab/data', {}

    assert_equal 400, last_response.status
    assert_equal "Missing Payload - 400 Bad Request", last_response.body
    assert_equal 0, Payload.count
  end

  def test_returns_403_forbidden_if_already_received_payload_request
    payload_data = { "requestedAt":"2013-02-16 21:38:28 -0700", "respondedIn":37}.to_json

    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    post '/sources/jumpstartlab/data', {payload: payload_data}

    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    post '/sources/jumpstartlab/data', {payload: payload_data}

    assert_equal 403, last_response.status
    assert_equal "Already Received Request - 403 Forbidden", last_response.body
    assert_equal 1, Payload.count
  end

end
