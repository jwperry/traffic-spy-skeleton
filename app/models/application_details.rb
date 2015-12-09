class ApplicationDetails

  def initialize
  end

  def get_full_path_frequencies(query_identifier)
    identifier_id = (Application.all.find { |app| app.identifier == query_identifier }).id
    matching_url_ids = (Payload.all.map { |pay| pay.full_url_path_id.to_s if pay.application_id == identifier_id }).compact
    url_count = {}
    matching_url_ids.each do |id|
      url_count.has_key?(id) ? (url_count[id] += 1) : (url_count[id] = 1)
    end
    url_count
  end
end

# 1 Most requested URLS to least requested URLS (url)
# 2 Web browser breakdown across all requests (userAgent)
# 3 OS breakdown across all requests (userAgent)
# 4 Screen Resolution across all requests (resolutionWidth x resolutionHeight)
# 5 Longest, average response time per URL to shortest, average response time per URL
# 6 Hyperlinks of each url to view url specific data
# 7 Hyperlink to view aggregate event data