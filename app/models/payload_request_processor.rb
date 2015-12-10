class PayloadRequestProcessor

  attr_accessor :raw_data

  def initialize(params)
    @raw_data = params
  end

  def process_payload
    if valid_json?
      parse_payload
    end
    raw_data
  end

  def valid_json?
    !raw_data["payload"].nil? 
  end

  def parse_payload
    raw_data['payload'] = JSON.parse(raw_data["payload"])
  end

  def missing_payload?
    raw_data["payload"] == nil
  end

  def already_received?
    Payload.all.any? {|pay| pay.requestedAt == raw_data['payload']["requestedAt"]}
  end

  def not_registered?
    Application.all.none? {|app| app.identifier == raw_data["identifier"]}
  end

  def create_payload
    payload = Payload.find_or_create_by(requestedAt: raw_data['payload']["requestedAt"],
                             respondedIn: raw_data['payload']["respondedIn"],
                             url_id: Url.find_or_create_by(url: raw_data['payload']["url"]).id)

    application = Application.find_by(identifier: raw_data['identifier'])
    application.payloads << payload
  end

  def process_request
    process_payload
      if missing_payload?
        {status: 400, body: "Missing Payload - 400 Bad Request"}
      elsif already_received?
        {status: 403, body: "Already Received Request - 403 Forbidden"}
      elsif not_registered?
        {status: 403, body: "Not Registered - 403 Forbidden"}
      else
        create_payload
        {status: 200, body: "200 OK"}
      end
  end
end
