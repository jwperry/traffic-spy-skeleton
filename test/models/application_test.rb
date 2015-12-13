require_relative '../test_helper'
require_relative '../simulation_environment/test_data.rb'

class ApplicationDetailsTest < ControllerTestSetup

  def setup
    td = TestData.new(2)
    td.generate
  end

  def test_app_returns_sorted_url_data
    app = Application.find_by(identifier: 'google')
    assert_equal "{#<Url id: 2, url: \"blog\">=>6, #<Url id: 1, url: \"images\">=>4, #<Url id: 3, url: \"store\">=>2}", app.sorted_urls_by_request.to_s
  end

  def test_app_returns_user_agent_breakdown_across_all_requests
    app = Application.find_by(identifier: 'google')
    assert_equal "Chrome 24.0.1309", app.user_agents.keys[0][:user_agent]
  end

  def test_os_breakdown_accross_all_requests
    app = Application.find_by(identifier: 'google')
    assert_equal "Mac OS X 10.8.2", app.user_agents.keys[0][:os]
  end

  def test_screen_reso_breakdown_accross_all_requests
    app = Application.find_by(identifier: 'google')
    assert_equal 2, app.screen_resolutions.count
    # assert_equal "{#<ScreenResolution id: 1, width: 10000, height: 12000>=>4, #<ScreenResolution id: 2, width: 500, height: 800>=>4, #<ScreenResolution id: 3, width: 15000, height: 20000>=>2, #<ScreenResolution id: 4, width: 100, height: 200>=>2}", app.screen_resolutions.to_s
  end

  def test_average_response_time
    app = Application.find_by(identifier: 'google')
    average_response_time = app.average_response_times.to_a
    assert_equal "images", average_response_time[0][0][:url]
    assert_equal 5.0, average_response_time[0][1].to_f
  end

  def test_event_returns_sorted_event_data
    app =  Application.find_by(identifier: 'google')
    assert_equal 4, app.sorted_events.count
  end

end
