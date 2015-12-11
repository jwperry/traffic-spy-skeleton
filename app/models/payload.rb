class Payload < ActiveRecord::Base
  belongs_to :application
  belongs_to :url
  belongs_to :user_agent
end
