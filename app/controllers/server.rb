module TrafficSpy

  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      rv = RequestValidator.new(params).validate_request
      status rv[:status]
      body   rv[:body]
    end

    post '/sources/:identifier/data' do
      parser = UserAgentParser::Parser.new
      prp = PayloadRequestProcessor.new(params, parser).process_request
      status prp[:status]
      body   prp[:body]
    end

    get '/sources/:identifier' do |identifier|
      @application = Application.find_by(identifier: identifier)
      @identifier = identifier
      erb :application_details
    end

    get '/sources/:identifier/urls/:path' do |identifier, path|
      @application = Application.find_by(identifier: identifier)
      @url = @application.urls.find_by(url: "http://#{identifier}.com/#{path}")
      erb :url_data
    end

    get '/sources/IDENTIFIER/events' do |identifier|
      @application = Application.find_by(identifier: identifier)
      erb :event_index
    end

    get '/sources/:identifier/events/:event_name' do |identifier, event_name|
      @application = Application.find_by(identifier: identifier)
      @event = @application.events.find_by(event: event_name)
      erb :event_data
    end

    not_found do
      erb :error
    end
  end
end
