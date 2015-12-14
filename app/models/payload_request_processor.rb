class PayloadRequestProcessor

  attr_accessor :raw_data

  def initialize(params, parser)
    @raw_data = params
    @parser = parser
  end

  def process_payload
    if valid_json?
      parse_payload
      parse_user_agent
      create_hex
    end
    raw_data
  end

  def valid_json?
    !raw_data["payload"].nil?
  end

  def parse_payload
    raw_data['payload'] = JSON.parse(raw_data["payload"])
  end

  def parse_user_agent
    ua_parse = @parser.parse(raw_data['payload']["userAgent"])
    raw_data['payload']['userAgent'] = {'user_agent' => ua_parse.to_s, 'os' => ua_parse.os.to_s}
  end

  def missing_payload?
    raw_data["payload"] == nil
  end

  def already_received?
    Payload.all.any? {|pay| pay.requested_at == raw_data['payload']["requestedAt"]}
  end

  def registered?
    # Application.all.none? {|app| app.identifier == raw_data["identifier"]}
    Payload.all.any? {|pay| pay.hex == raw_data['payload']['hex']}
  end

  def create_hex
    raw_data["payload"]["hex"] = Digest::SHA1.hexdigest raw_data['payload'].to_s
  end

  def create_payload
    payload = CreatePayload.new(raw_data).create_payload
    application = Application.find_by(identifier: raw_data['identifier'])
    application.payloads << payload
  end

  def process_request
    process_payload
      if missing_payload?
        {status: 400, body: "Missing Payload - 400 Bad Request"}
      elsif already_received?
        {status: 403, body: "Already Received Request - 403 Forbidden"}
      elsif registered?
        {status: 403, body: "Not Registered - 403 Forbidden"}
      else
        create_payload
        {status: 200, body: "200 OK"}
      end
  end
end
