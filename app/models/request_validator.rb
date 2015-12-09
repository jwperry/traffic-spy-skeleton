class RequestValidator

  def self.validate_request(params)
    application_exists?(params)
  end

  def self.application_exists?(params)
    if Application.all.any? {|app| app.identifier == params[:identifier]}
      {status: 403, body: "Identifier Already Exists - 403 Forbidden"}
    else
      application_save?(params)
    end
  end

  def self.application_save?(params)
    application  = Application.create(identifier: params[:identifier], root_url: params[:rootUrl])
    if application.save
      {status: 200, body: "{identifier: #{params[:identifier]}}"}
    else
      missing_parameters?(params)
    end
  end

  def self.missing_parameters?(params)
    if params.has_key?('identifier')
      {status: 400, body: "Missing root URL - 400 Bad Request"}
    else
      {status: 400, body: "Missing Identifier - 400 Bad Request"}
    end
  end

end
