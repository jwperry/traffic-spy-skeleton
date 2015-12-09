class ApplicationDetails

  def initialize
  end

  def get_full_path_frequencies(query_identifier)
    url_count = Payload.where("application_id = 2").group(:full_url_path_id).count

    url_order = url_count.sort_by {|a, b| b}.reverse.to_h
    url_order.map{|a, b| a}
  end
end

# 1 Most requested URLS to least requested URLS (url)
# 2 Web browser breakdown across all requests (userAgent)
# 3 OS breakdown across all requests (userAgent)
# 4 Screen Resolution across all requests (resolutionWidth x resolutionHeight)
# 5 Longest, average response time per URL to shortest, average response time per URL
# 6 Hyperlinks of each url to view url specific data
# 7 Hyperlink to view aggregate event data
