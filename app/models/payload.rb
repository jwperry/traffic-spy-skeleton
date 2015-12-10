class Payload < ActiveRecord::Base
  belongs_to :application
  belongs_to :url
end
