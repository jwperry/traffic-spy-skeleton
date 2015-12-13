class Payload < ActiveRecord::Base
  belongs_to :application
  belongs_to :url
  belongs_to :user_agent
  belongs_to :screen_resolution
  belongs_to :verb
  belongs_to :referrer
  belongs_to :event
end
