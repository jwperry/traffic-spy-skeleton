require_relative '../test_helper'
require_relative '../simulation_environment/test_data.rb'

class ApplicationDetailsTest < ControllerTestSetup

  def setup
    td = TestData.new
    td.generate
  end

  def test_app_returns_sorted_url_data
    setup
    app = Application.find_by(identifier: 'google')
    assert_equal '{#<Url id: 6, url: "http://google.com/blog">=>20, #<Url id: 7, url: "http://google.com/store">=>20, #<Url id: 5, url: "http://google.com/images">=>20, #<Url id: 8, url: "http://google.com/fun_stuff">=>20}', app.sorted_urls.to_s
  end

end
