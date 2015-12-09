class RequestValidator

  def self.validate_request(params)
    if application_exists?(params)
      {status: 403, body: "Identifier Already Exists - 403 Forbidden"}
    elsif application_save?(params)
      {status: 200, body: "{identifier: #{params[:identifier]}}"}
    elsif missing_root_url?(params)
      {status: 400, body: "Missing root URL - 400 Bad Request"}
    elsif missing_identifier?(params)
      {status: 400, body: "Missing Identifier - 400 Bad Request"}
    end
  end

  def self.application_exists?(params)
    Application.all.any? {|app| app.identifier == params[:identifier]}
  end

  def self.application_save?(params)
    application  = Application.create(identifier: params[:identifier], root_url: params[:rootUrl])
    application.save
  end

  def self.missing_root_url?(params)
    params.has_key?('identifier')
  end

  def self.missing_identifier?(params)
    params.has_key?('rootUrl')
  end

end
