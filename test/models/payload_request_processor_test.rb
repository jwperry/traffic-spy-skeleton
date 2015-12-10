# require_relative '../test_helper'
#
# class PayloadRequestProcessorTest < ControllerTestSetup
#
#   def setup
#     @payload_data = {"url": "http://jumpstartlab.com/blog",
#                 "requestedAt": "2013-02-16 21:38:28 -0700",
#                 "respondedIn": 37,
#                 "referredBy": "http://jumpstartlab.com",
#                 "requestType": "GET",
#                 "parameters": [],
#                 "eventName": "socialLogin",
#                 "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#                 "resolutionWidth": "1920",
#                 "resolutionHeight": "1280",
#                 "ip": "63.29.38.211"}.to_json
#
#     @unjsoned_data = {:payload=>
#                     {"url"=>"http://jumpstartlab.com/blog",
#                  "requestedAt"=>"2013-02-16 21:38:28 -0700",
#                  "respondedIn"=>37,
#                  "referredBy"=>"http://jumpstartlab.com",
#                  "requestType"=>"GET",
#                  "parameters"=>[],
#                  "eventName"=>"socialLogin",
#                  "userAgent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#                  "resolutionWidth"=>"1920",
#                  "resolutionHeight"=>"1280",
#                  "ip"=>"63.29.38.211"},
#                  "splat"=>[],
#                  "captures"=>["jumpstartlab"],
#                  "IDENTIFIER"=>"jumpstartlab"}
#   end
#
#   def test_json_parses
#     params = @payload_data
#
#   parsed_payload = PayloadRequestProcessor.json_parse?({"payload" => params})
#
#     assert_equal({"payload"=>"{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"}, parsed_payload)
#   end
#   #
#   # def test_if_nil_json_parse_returns_input
#   #   params = {payload: nil}
#   #   parsed_payload = PayloadRequestProcessor.json_parse?(params)
#   #
#   #   assert_equal({:payload=>nil}, parsed_payload)
#   # end
#   #
#   # def test_payload_is_missing
#   #   params = {payload: nil}
#   #   assert PayloadRequestProcessor.missing_payload?(params)
#   # end
#   #
#   # # def test_payload_is_already_received
#   #   # ERROR MESSAGE GIVEN IS FAILED ASSERTION, NO MESSAGE. ALREADY RECEIVED IS ONLY GETTING THE POST ONCE
#   #   # params = @payload_data
#   #   # post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
#   #   # post '/sources/jumpstartlab/data', {payload: params}
#   #   # parsed_payload = PayloadRequestProcessor.json_parse?(payload: params)
#   #   # # binding.pry
#   #   # do_this = PayloadRequestProcessor.already_received?(parsed_payload)
#   #   # assert PayloadRequestProcessor.already_received?(parsed_payload)
#   #
#   #    # ATTEMPT 2
#   #   # params = {payload: @payload_data}
#   #   # post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
#   #   # post '/sources/jumpstartlab/data', {payload: params}
#   #   # parsed_payload = JSON.parse(params[:payload])
#   #   # params[:payload] = parsed_payload
#   #   # assert PayloadRequestProcessor.already_received?(params[:payload])
#   # # end
#   #
#   # def test_identifier_is_not_registered
#   #   assert PayloadRequestProcessor.not_registered?(@unjsoned_data)
#   # end
#   #
#   # def test_create_payload
#   #   post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
#   #   assert PayloadRequestProcessor.create_payload(@unjsoned_data)
#   # end


# end
