class Payload < ActiveRecord::Base
  belongs_to :application
  belongs_to :full_url_path
end
