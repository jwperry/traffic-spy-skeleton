require 'date'

class Event < ActiveRecord::Base
  # belongs_to :payload
  has_many :payloads

  def event_by_hour
    times = {}
    24.times do |i|
      times[i] = find_payloads_for_hour(i).count
    end
    times
  end

  def get_hour(payload)
    DateTime.parse(payload[:requested_at]).hour
  end

  def find_payloads_for_hour(hour)
    payloads.to_a.find_all {|payload| get_hour(payload) == hour}
  end

  def total_event_count
    payloads.to_a.count
  end


end
