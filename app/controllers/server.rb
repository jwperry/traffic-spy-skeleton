module TrafficSpy

  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      rv = RequestValidator.new(params).validate_request
      status rv[:status]
      # status rv.status
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
      @application.urls.find_by(url: path)
    end

    not_found do
      erb :error
    end
  end
end
