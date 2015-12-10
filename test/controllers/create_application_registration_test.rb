# require_relative '../test_helper'
#
# class CreateAppRegistrarTest < ControllerTestSetup
#
#   def test_route_web_app_with_valid_request
#     post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
#
#     assert_equal 200, last_response.status
#   end
#
#   def test_registers_web_app_with_valid_request
#     post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
#     identifier = "{identifier: jumpstartlab}"
#
#     assert_equal identifier, last_response.body
#     assert_equal 1, Application.count
#   end
#
#   def test_returns_400_when_request_is_missing_identifier
#     post '/sources', 'rootUrl=http://jumpstartlab.com'
#
#     assert_equal 400, last_response.status
#     assert_equal 0, Application.count
#     assert_equal "Missing Identifier - 400 Bad Request", last_response.body
#   end
#
#   def test_returns_400_when_request_is_missing_url
#     post '/sources', 'identifier=jumpstartlab'
#
#     assert_equal 400, last_response.status
#     assert_equal 0, Application.count
#     assert_equal "Missing root URL - 400 Bad Request", last_response.body
#   end
#
#   def test_returns_403_when_app_identifier_already_exists
#     Application.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
#     # post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
#     post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
#
#     assert_equal 403, last_response.status
#     assert_equal 1, Application.count
#     assert_equal "Identifier Already Exists - 403 Forbidden", last_response.body
#   end
#
# end
