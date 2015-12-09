class Application < ActiveRecord::Base
  validates_presence_of :identifier, :root_url
  has_many :payloads
end