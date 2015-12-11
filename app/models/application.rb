class Application < ActiveRecord::Base
  validates_presence_of :identifier, :rootUrl
  has_many :payloads
  has_many :urls, through: :payloads

  def sorted_urls
    payloads.group(:url).count.sort_by{|a,b| (b * -1)}.to_h
  end
end
