require_relative '../test_helper'

class PayloadRequestProcessorTest < ControllerTestSetup

  def setup


    @params = {"url": "http://jumpstartlab.com/blog",
                "requestedAt": "2013-02-16 21:38:28 -0700",
                "respondedIn": 37,
                "referredBy": "http://jumpstartlab.com",
                "requestType": "GET",
                "parameters": [],
                "eventName": "socialLogin",
                "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth": "1920",
                "resolutionHeight": "1280",
                "ip": "63.29.38.211"}.to_json

    @processed_params = {'payload'=>
                    {"url"=>"http://jumpstartlab.com/blog",
                 "requestedAt"=>"2013-02-16 21:38:28 -0700",
                 "respondedIn"=>37,
                 "referredBy"=>"http://jumpstartlab.com",
                 "requestType"=>"GET",
                 "parameters"=>[],
                 "eventName"=>"socialLogin",
                 "userAgent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                 "resolutionWidth"=>"1920",
                 "resolutionHeight"=>"1280",
                 "ip"=>"63.29.38.211"},
                 "splat"=>[],
                 "captures"=>["jumpstartlab"],
                 "identifier"=>"jumpstartlab"}
  end

  def test_json_parses
    parsed_payload = PayloadRequestProcessor.new({"payload" => @params})
    parsed_payload.process_payload

    assert_equal({"payload"=>{"url"=>"http://jumpstartlab.com/blog", "requestedAt"=>"2013-02-16 21:38:28 -0700", "respondedIn"=>37, "referredBy"=>"http://jumpstartlab.com", "requestType"=>"GET", "parameters"=>[], "eventName"=>"socialLogin", "userAgent"=>{"user_agent"=>"Chrome 24.0.1309", "os"=>"Mac OS X 10.8.2"}, "resolutionWidth"=>"1920", "resolutionHeight"=>"1280", "ip"=>"63.29.38.211"}}, parsed_payload.raw_data)
  end

  def test_valid_json
    parsed_payload = PayloadRequestProcessor.new({'payload' => nil})
    refute parsed_payload.valid_json?
  end

  def test_parse_payload
    parsed_payload = PayloadRequestProcessor.new({"payload" => @params})
    assert_equal ({"payload"=>{"url"=>"http://jumpstartlab.com/blog", "requestedAt"=>"2013-02-16 21:38:28 -0700", "respondedIn"=>37, "referredBy"=>"http://jumpstartlab.com", "requestType"=>"GET", "parameters"=>[], "eventName"=>"socialLogin", "userAgent"=>{"user_agent"=>"Chrome 24.0.1309", "os"=>"Mac OS X 10.8.2"}, "resolutionWidth"=>"1920", "resolutionHeight"=>"1280", "ip"=>"63.29.38.211"}}), parsed_payload.process_payload
  end

  def test_if_nil_json_parse_returns_input
    parsed_payload = PayloadRequestProcessor.new({"payload" => nil})
    parsed_payload.process_payload

    assert_equal({"payload"=>nil}, parsed_payload.raw_data)
  end

  def test_payload_is_missing
    parsed_payload = PayloadRequestProcessor.new({"payload" => nil})
    parsed_payload.process_payload

    assert parsed_payload.missing_payload?
  end

  def test_identifier_is_not_registered
    parsed_payload = PayloadRequestProcessor.new({"payload" => @params})
    parsed_payload.process_payload

    assert parsed_payload.not_registered?
  end

  def test_create_payload

    params = {identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"}
    Application.create(params)

    parsed_payload = PayloadRequestProcessor.new(@processed_params)
    parsed_payload.create_payload

    assert_equal 1, Payload.all.count
  end

end
#
# def test_payload_is_already_received
#   # ERROR MESSAGE GIVEN IS FAILED ASSERTION, NO MESSAGE. ALREADY RECEIVED IS ONLY GETTING THE POST ONCE
#   params = @params
#   post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
#   post '/sources/jumpstartlab/data', {payload: params}
#   parsed_payload = PayloadRequestProcessor.json_parse?(payload: params)
#   do_this = PayloadRequestProcessor.already_received?(parsed_payload)
#   assert PayloadRequestProcessor.already_received?(parsed_payload)
#
# end
