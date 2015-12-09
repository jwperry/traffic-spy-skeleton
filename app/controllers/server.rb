module TrafficSpy

  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      rv = RequestValidator.validate_request(params)
      status rv[:status]
      body rv[:body]
    end

    post '/sources/:IDENTIFIER/data' do
      parsed_payload = JSON.parse(params[:payload])
      payload = Payload.create(requestedAt: parsed_payload["requestedAt"], respondedIn: parsed_payload["respondedIn"])
      application = Application.all.find { |app| app[:identifier] == params["IDENTIFIER"] }
      application.payloads << payload
    end

    not_found do
      erb :error
    end
  end
end

# As a user
# When I send a POST request to 'http://yourapplication:port/sources/IDENTIFIER/data' 
# And I send all payload parameters
# Then I get a response of 'Success - 200 OK'