module TrafficSpy

  class Server < Sinatra::Base

    def initialize
      @parser = UserAgentParser::Parser.new
    end

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
      prp = PayloadRequestProcessor.new(params, @parser).process_request
      status prp[:status]
      body   prp[:body]
    end

    get '/sources/:identifier' do |identifier|
      @application = Application.find_by(identifier: identifier)
      @application.sorted_urls

      erb :application_details
    end

    not_found do
      erb :error
    end
  end
end
