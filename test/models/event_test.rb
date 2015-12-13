require_relative '../test_helper'
require_relative '../simulation_environment/test_data.rb'

class EventTest < ControllerTestSetup

  def setup
    td = TestData.new(2)
    td.generate
  end

  def test_breaks_down_hourly
    app = Application.find_by(identifier: 'google')
    event = app.events.find_by(event: 'Social')
    hash = "{0=>1, 1=>1, 2=>1, 3=>1, 4=>1, 5=>0, 6=>2, 7=>0, 8=>1, 9=>0, 10=>0, 11=>0, 12=>0, 13=>0, 14=>1, 15=>0, 16=>0, 17=>0, 18=>0, 19=>0, 20=>0, 21=>0, 22=>2, 23=>1}"
    event_by_hour = event.event_by_hour
    assert_equal 24, event_by_hour.count
    # assert_equal hash, event_by_hour.to_s
  end

  def test_event_request_count
    app = Application.find_by(identifier: 'google')
    event = app.events.find_by(event: 'Social')
    assert_equal 12, event.total_event_count
  end



end
