class UserAgent < ActiveRecord::Base
  # belongs_to :payload
  has_many :payloads
end
