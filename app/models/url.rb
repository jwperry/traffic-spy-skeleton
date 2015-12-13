class Url < ActiveRecord::Base
  # belongs_to :payload
  has_many :payloads

  def sorted_url_response_times
    payloads.order(responded_in: :desc).to_a
  end

  def average_url_response_time
    payloads.average(:responded_in)
  end

end
