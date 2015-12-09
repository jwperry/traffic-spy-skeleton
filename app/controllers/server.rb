module TrafficSpy

  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      rv = RequestValidator.validate_request(params)
      status rv[:status]
      body   rv[:body]
    end

    post '/sources/:IDENTIFIER/data' do
      prp = PayloadRequestProcessor.process_request(params)
      status prp[:status]
      body   prp[:body]
    end

    not_found do
      erb :error
    end
  end
end
