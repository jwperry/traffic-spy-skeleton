class Application < ActiveRecord::Base
  validates_presence_of :identifier, :root_url
  has_many :payloads
  has_many :urls, through: :payloads
  has_many :user_agents, through: :payloads
  has_many :screen_resolutions, through: :payloads
  has_many :verbs, through: :payloads
  has_many :referrers, through: :payloads
  has_many :events, through: :payloads

  def sorted_urls_by_request
    payloads.group(:url).count.sort_by{|a,b| (b * -1)}.to_h
  end

  def uniq_user_agents
    user_agents.all.uniq.pluck(:user_agent, :os)
  end

  def uniq_screen_resolutions
    screen_resolutions.all.uniq.pluck(:width, :height)
  end

  def average_response_times
    payloads.group(:url).average(:responded_in).sort_by{|a,b| (b * -1)}.to_a
  end

  def sorted_events
    events = payloads.group(:event).count.sort_by{|a,b| (b * -1)}.to_a
    events.map {|event| [event[0][:event], event[1]] }
  end


end
