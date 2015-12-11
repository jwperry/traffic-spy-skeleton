require_relative '../test_helper'
require_relative '../simulation_environment/test_data.rb'

class ApplicationDetailsTest < ControllerTestSetup

  def setup
    td = TestData.new
    td.generate
  end

  def test_app_returns_sorted_url_data
    app = Application.find_by(identifier: 'google')
    assert_equal '{#<Url id: 2, url: "http://google.com/blog">=>30, #<Url id: 1, url: "http://google.com/images">=>20, #<Url id: 3, url: "http://google.com/store">=>10}', app.sorted_urls.to_s
  end

  def test_app_returns_user_agent_data
    app = Application.find_by(identifier: 'google')
    assert_equal '{#<UserAgent id: 1, user_agent: "Chrome 24.0.1309", os: "Mac OS X 10.8.2">=>60}', app.user_agents.to_s
  end

  def test_os_breakdown_accross_all_requests
    app = Application.find_by(identifier: 'google')
    assert_equal '{#<UserAgent id: 1, user_agent: "Chrome 24.0.1309", os: "Mac OS X 10.8.2">=>60}', app.user_agents.to_s
  end


end
