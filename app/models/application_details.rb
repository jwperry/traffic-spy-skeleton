class ApplicationDetails

  def initialize
  end

  def get_full_path_frequencies(query_identifier)
    # get ID of identifier
    identifier_id = (Application.all.find { |app| app.identifier == query_identifier }).id
    # XXXXXXXXXXXXXXget all full_url_paths linked to that ID
    # select all payloads where application_id maps to identifier in applications table
    matching_url_ids = Payload.all.map { |pay| pay.full_url_path_id if pay.application_id == identifier_id }
    # iterate through all payloads mapping to application_id and use them as keys
    
    # in a hash...increment value (starting at 0) by 1 for every match

    # ...?

    # profit


  end









end

# 1 Most requested URLS to least requested URLS (url)
# 2 Web browser breakdown across all requests (userAgent)
# 3 OS breakdown across all requests (userAgent)
# 4 Screen Resolution across all requests (resolutionWidth x resolutionHeight)
# 5 Longest, average response time per URL to shortest, average response time per URL
# 6 Hyperlinks of each url to view url specific data
# 7 Hyperlink to view aggregate event data