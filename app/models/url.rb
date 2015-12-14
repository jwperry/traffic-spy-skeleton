class Url < ActiveRecord::Base
  # belongs_to :payload
  has_many :payloads
  has_many :verbs, through: :payloads

  def sorted_url_response_times
    payloads.order(responded_in: :desc).to_a
  end

  def average_url_response_time
    payloads.average(:responded_in)
  end

  def used_http_verbs
    verbs.all.uniq.pluck(:verb)
  end

  def top_three_rank(target)
    top = payloads.group(target).count.sort_by{|a,b| (b * -1)}.to_a
    top[0..2].map { |ref| [ref[0][target], ref[1]] }
  end

end
