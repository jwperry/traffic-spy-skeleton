module TrafficSpy

  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      rv = RequestValidator.validate_request(params)
      status rv[:status]
      # status rv.status
      body   rv[:body]
    end

    post '/sources/:IDENTIFIER/data' do
      prp = PayloadRequestProcessor.process_request(params)
      status prp[:status]
      body   prp[:body]
    end

    get '/sources/:IDENTIFIER' do |identifier|
      @application = Application.find_by(identifier: identifier)
      # @sorted_url_frequency = ApplicationDetails.get_full_path_frequencies(identifier)
      erb :application_details
    end

    not_found do
      erb :error
    end
  end
end
