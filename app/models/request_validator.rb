class RequestValidator

  attr_accessor :raw_data

  def initialize(params)
    @raw_data = params
  end

  def validate_request
    if application_exists?
      {status: 403, body: "Identifier Already Exists - 403 Forbidden"}
    elsif application_save?
      {status: 200, body: "{identifier: #{raw_data[:identifier]}}"}
    elsif missing_rootUrl?
      {status: 400, body: "Missing root URL - 400 Bad Request"}
    elsif missing_identifier?
      {status: 400, body: "Missing Identifier - 400 Bad Request"}
    end
  end

  def application_exists?
    Application.all.any? {|app| app.identifier == raw_data[:identifier]}
  end

  def application_save?
    application  = Application.new(identifier: raw_data[:identifier], root_url: raw_data['rootUrl'])
    application.save
  end

  def missing_rootUrl?
    !(raw_data.has_key?('rootUrl'))
  end

  def missing_identifier?
    !(raw_data.has_key?('identifier'))
  end

end
