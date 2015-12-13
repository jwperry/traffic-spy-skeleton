require_relative '../test_helper'
require_relative '../simulation_environment/test_data.rb'

class ApplicationDetailsTest < ControllerTestSetup

  def setup
    td = TestData.new(2)
    td.generate
  end

  def test_average_response_time
    app = Application.find_by(identifier: 'google')
    url = app.urls.find_by(url: 'blog')
    average_response_time = url.sorted_url_response_times.to_a
    assert_equal 4.0, url.average_url_response_time.to_f
  end

  def test_largest_response_time
    app = Application.find_by(identifier: 'google')
    url = app.urls.find_by(url: 'blog')
    average_response_time = url.sorted_url_response_times.to_a
    assert_equal 7, url.sorted_url_response_times[0][:responded_in]
  end

  def test_smallest_response_time
    app = Application.find_by(identifier: 'google')
    url = app.urls.find_by(url: 'blog')
    average_response_time = url.sorted_url_response_times.to_a
    assert_equal 1, url.sorted_url_response_times[-1][:responded_in]
  end

  def test_smallest_response_time
    app = Application.find_by(identifier: 'google')
    url = app.urls.find_by(url: 'blog')
    average_response_time = url.sorted_url_response_times.to_a
    assert_equal 1, url.sorted_url_response_times[-1][:responded_in]
  end

  def test_http_verbs_are_used
    app = Application.find_by(identifier: 'google')
    url = app.urls.find_by(url: 'blog')
    used_http_verbs = url.used_http_verbs.to_a
    assert_equal 1, used_http_verbs.count
  end

  def test_referrers_are_top_threed
    app = Application.find_by(identifier: 'google')
    url = app.urls.find_by(url: 'blog')
    top_three_referrers = url.top_three_rank(:referrer).to_a
    assert_equal 3, top_three_referrers.count
    # assert_equal "[[#<Referrer id: 1, referrer: \"http://bing.com\">, 4], [#<Referrer id: 4, referrer: \"http://dogpile.com\">, 4], [#<Referrer id: 2, referrer: \"http://yahoo.com\">, 4], [#<Referrer id: 3, referrer: \"http://askjeeves.com\">, 3], [#<Referrer id: 5, referrer: \"http://google.com\">, 3]]", top_three_referrers.to_s
  end

  def test_top_three_user_agents
    app = Application.find_by(identifier: 'google')
    url = app.urls.find_by(url: 'blog')
    top_three_user_agents = url.top_three_rank(:user_agent).to_a
    assert_equal 1, top_three_user_agents.count
    assert_equal '[[#<UserAgent id: 1, user_agent: "Chrome 24.0.1309", os: "Mac OS X 10.8.2">, 18]]', top_three_user_agents.to_s
  end

end
