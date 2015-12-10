class ApplicationDetails

  def self.get_full_path_frequencies(query_identifier)
    binding.pry
    id = Application.all.find {|app| app.identifier == query_identifier}.id
    url_count = Payload.where("application_id = #{id}").group(:full_url_path_id).count

    url_order = url_count.sort_by {|a, b| b}.reverse.to_h

    hash = {}
    url_order.each do |a, b|
      a = FullUrlPath.find(a).full_url_path
      hash[a] = b
    end
    hash
  end

end

# 1 Most requested URLS to least requested URLS (url)
# 2 Web browser breakdown across all requests (userAgent)
# 3 OS breakdown across all requests (userAgent)
# 4 Screen Resolution across all requests (resolutionWidth x resolutionHeight)
# 5 Longest, average response time per URL to shortest, average response time per URL
# 6 Hyperlinks of each url to view url specific data
# 7 Hyperlink to view aggregate event data
