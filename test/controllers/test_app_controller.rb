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

  def test_route_web_app_with_valid_request
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'

    assert_equal 200, last_response.status
  end

  def test_registers_web_app_with_valid_request
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    identifier = "{identifier: jumpstartlab}"

    assert_equal identifier, last_response.body
    assert_equal 1, Application.count
  end

  def test_returns_400_when_request_is_missing_identifier
    post '/sources', 'rootUrl=http://jumpstartlab.com'

    assert_equal 400, last_response.status
    assert_equal 0, Application.count
    assert_equal "Missing Identifier - 400 Bad Request", last_response.body
  end

  def test_returns_400_when_request_is_missing_url
    post '/sources', 'identifier=jumpstartlab'

    assert_equal 400, last_response.status
    assert_equal 0, Application.count
    assert_equal "Missing root URL - 400 Bad Request", last_response.body
  end

  def test_returns_403_when_app_identifier_already_exists
    Application.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    # post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'

    assert_equal 403, last_response.status
    assert_equal 1, Application.count
    assert_equal "Identifier Already Exists - 403 Forbidden", last_response.body
  end

  def test_can_find_url
    Application.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    post '/sources/jumpstartlab/data', {payload: @payload_data}
    get '/sources/jumpstartlab/urls/blog'
    assert_equal "", url.longest_response_time
  end

end
