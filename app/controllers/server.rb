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
      prp = PayloadRequestProcessor.process_request(params)
      # # (parsed_payload = JSON.parse(params[:payload])) if params[:payload] != nil
      # if params[:payload] == nil
      #   status 400
      #   body "Missing Payload - 400 Bad Request"
      # elsif Payload.all.any? {|pay| pay.requestedAt == parsed_payload["requestedAt"]}
      #     # {status: 403, body: "Payload Already Exists - 403 Forbidden"}
      #     status 403
      #     body "Already Received Request - 403 Forbidden"
      # else
      #   payload = Payload.create(requestedAt: parsed_payload["requestedAt"], respondedIn: parsed_payload["respondedIn"])
      #   application = Application.all.find { |app| app[:identifier] == params["IDENTIFIER"] }
      #   application.payloads << payload
      # end
      status prp[:status]
      body prp[:body]
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
