class Url < ActiveRecord::Base
  # belongs_to :payload
  has_many :payloads

  def sorted_url_response_times
    payloads.order(responded_in: :desc).to_a
  end

  def average_url_response_time
    payloads.average(:responded_in)
  end

  def used_http_verbs
    payloads.group(:verb).count.to_a
  end

  def top_three_rank(target)
    payloads.group(target).count.sort_by{|a,b| (b * -1)}.to_h
  end

end
