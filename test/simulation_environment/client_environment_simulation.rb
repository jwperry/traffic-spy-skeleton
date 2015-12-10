require_relative '../test_helper'

class ClientEnvironmentSimulator < ControllerTestSetup

  def initialize
    @client = ["jumpstartlab", "google", "metacritic", "binglol"]
    @client_url = ["images", "blog", "store", "fun_stuff"]
    @request_type = ["GET", "POST"]
    @event_name = ["Social", "Dog", "Dad?", "ComputerStuff"]
    @user_agent = "Mozilla"
    @resolution = [[10000, 12000], [500, 800], [15000, 20000]]
    @ip = ["63.29.38.211", "64.92.38.211", "14.92.38.300"]
  end


  def start_simulation_test
    client_registration_test

    10.times do
      client_request_test
    end
  end

  def start_simulation_development
    client_registration_development

    10.times do
      client_request_development
    end
  end

  def client_registration_test
    @client.each do |client|
      post '/sources', "identifier=#{client}&rootUrl=http://#{client}.com"
    end
  end

  def client_registration_development
    @client.each do |client|
      `curl -i -d "identifier=#{client}&rootUrl=http://#{client}.com" http://localhost:9393/sources`
    end
  end


  def client_request_test
    resolution = @resolution.sample
    client = @client.sample
    payload_data = {"url": "http://#{client}.com/#{@client_url.sample}",
                    "requestedAt": "#{rand(2014..2015)}-#{rand(1..12)}-#{rand(1..30)} #{rand(0..24)}:#{rand(0..60)}:#{rand(0..60)} -#{rand(0..2400)}",
                    "respondedIn": rand(0..30),
                    "referredBy": "http://#{client}.com",
                    "requestType": "#{@request_type.sample}",
                    "parameters": [],
                    "eventName": "#{@event_name.sample}",
                    "userAgent": "#{@user_agent}",
                    "resolutionWidth": "#{resolution[0]}",
                    "resolutionHeight": "#{resolution[1]}",
                    "ip": "#{@ip.sample}"}.to_json


    post "/sources/#{client}/data", {payload: payload_data}
  end

  def client_request_development
      resolution = @resolution.sample
      client = @client.sample
      `curl -i -d 'payload={"url": "http://#{client}.com/#{@client_url.sample}",
                      "requestedAt": "#{rand(2014..2015)}-#{rand(1..12)}-#{rand(1..30)} #{rand(0..24)}:#{rand(0..60)}:#{rand(0..60)} -#{rand(0..2400)}",
                      "respondedIn": #{rand(0..30)},
                      "referredBy": "http://#{client}.com",
                      "requestType": "#{@request_type.sample}",
                      "parameters": [],
                      "eventName": "#{@event_name.sample}",
                      "userAgent": "#{@user_agent}",
                      "resolutionWidth": "#{resolution[0]}",
                      "resolutionHeight": "#{resolution[1]}",
                      "ip": "#{@ip.sample}"}' http://localhost:9393/sources/#{client}/data`

                      p "imported payload"
    end


end
