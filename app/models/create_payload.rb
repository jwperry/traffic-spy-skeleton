class CreatePayload

  attr_reader :raw_data

  def initialize(raw_data)
    @raw_data = raw_data
  end

  def create_payload
    Payload.find_or_create_by(requested_at:        raw_data['payload']["requestedAt"],
                             responded_in:         raw_data['payload']["respondedIn"],
                             hex:                  raw_data['payload']['hex'],
                             referrer_id:          referrer,
                             verb_id:              verb,
                             url_id:               url,
                             event_id:             event,
                             user_agent_id:        user_agent,
                             screen_resolution_id: screen_resolution)
  end

  def referrer
    Referrer.find_or_create_by(referrer: raw_data['payload']['referredBy']).id
  end

  def verb
    Verb.find_or_create_by(verb: raw_data['payload']['requestType']).id
  end

  def url
    Url.find_or_create_by(url: relative_path).id
  end

  def event
    Event.find_or_create_by(event: raw_data['payload']['eventName']).id
  end

  def user_agent
    UserAgent.find_or_create_by(user_agent: raw_data['payload']['userAgent']['user_agent'], os: raw_data['payload']['userAgent']['os']).id
  end

  def screen_resolution
    ScreenResolution.find_or_create_by(height: raw_data['payload']["resolutionHeight"], width: raw_data['payload']["resolutionWidth"]).id
  end

  def relative_path
    parse = raw_data['payload']['url'].split('/')
    3.times {parse.shift}
    (parse.count == 1) ? parse[0] : parse.join('/')
  end

end
