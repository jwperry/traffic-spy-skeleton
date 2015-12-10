class Application < ActiveRecord::Base
  validates_presence_of :identifier, :rootUrl
  has_many :payloads
  has_many :urls, through: :payloads

  def add_payload(payload)
    self.payloads.build(:payload => payload)
  end

  # def sorted_urls
    # urls.
    # payloads.group(:url_id).count
    # ActiveRecord #order method
  # end
end
