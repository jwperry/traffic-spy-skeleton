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

end
