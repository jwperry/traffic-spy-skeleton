class Application < ActiveRecord::Base
  validates_presence_of :identifier, :root_url
  has_many :payloads
  # has_many :urls, through: :payloads

  # def sorted_urls
    # urls.
    # payloads.group(:full_url_path_id).count
    # ActiveRecord #order method
  # end
end
