module TrafficSpy

  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      rv = RequestValidator.new(params)
      rv.validate_request
      status rv.status
      body   rv.body
    end

    post '/redirect_to_application_details' do
      @application = Application.find_by(identifier: params["identifier"])
      redirect "/sources/#{params["identifier"]}"
    end

    get '/register' do
      erb :register
    end

    post '/register' do
      rv = RequestValidator.new(params)
      rv.validate_request
      redirect '/'
    end

    post '/sources/:identifier/data' do
      parser = UserAgentParser::Parser.new
      prp = PayloadRequestProcessor.new(params, parser)
      prp.process_request
      status prp.status
      body   prp.body
    end

    get '/sources/:identifier' do |identifier|
      @application = Application.find_by(identifier: identifier)
      @identifier = identifier
      erb ViewRoute.application(@application)
    end

    get '/sources/:identifier/urls/:path' do |identifier, path|
      @application = Application.find_by(identifier: identifier)
      @url = @application.urls.find_by(url: path)
      @identifier = identifier
      @url_path = path
      erb ViewRoute.url_route(@application, @url)
    end

    get '/sources/:identifier/events' do |identifier|
      @application = Application.find_by(identifier: identifier)
      @identifier = identifier
      erb ViewRoute.events_index_route(@application)
    end

    get '/sources/:identifier/events/:event_name' do |identifier, event_name|
      @event_name = event_name
      @application = Application.find_by(identifier: identifier)
      @event = @application.events.find_by(event: event_name)
      @identifier = identifier
      erb ViewRoute.event_route(@application, @event)
    end

    not_found do
      erb :error
    end
  end
end