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

    post '/redirect_to_application_details' do
      @application = Application.find_by(identifier: params["identifier"])
      #need method call to redirect class here once jordan is done
      #route to application_details for identifier or error page
      redirect "/sources/#{params["identifier"]}"
    end

    get '/register' do
      erb :register
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
      @url = @application.urls.find_by(url: path)
      @identifier = identifier
      erb :url_data
    end

    get '/sources/:identifier/events' do |identifier|
      @application = Application.find_by(identifier: identifier)
      @identifier = identifier
      erb :event_index
    end

    get '/sources/:identifier/events/:event_name' do |identifier, event_name|
      @application = Application.find_by(identifier: identifier)
      @event = @application.events.find_by(event: event_name)
      @identifier = identifier
      erb :event_data
    end

    not_found do
      erb :error
    end
  end
end
