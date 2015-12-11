class Application < ActiveRecord::Base
  validates_presence_of :identifier, :root_url
  has_many :payloads
  has_many :urls, through: :payloads
  has_many :user_agents, through: :payloads

  def sorted_urls
    payloads.group(:url).count.sort_by{|a,b| (b * -1)}.to_h
  end

  def user_agents
    payloads.group(:user_agent).count.sort_by{|a,b| (b * -1)}.to_h
  end

end
