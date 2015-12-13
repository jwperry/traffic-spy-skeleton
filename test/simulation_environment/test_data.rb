require_relative '../test_helper'

class  TestData < ControllerTestSetup

  def initialize(iterations)
    @client = ["google", "jumpstartlab", "metacritic"]
    @client_url = ["images", "blog", "store", "blog", "store", "store"]
    @request_type = ["GET", "POST", "GET", "POST"]
    @responded_in = [1,2,3,4,5,6,7,8]
    @event_name = ["Social", "Dog", "Dad?", "ComputerStuff"]
    @user_agent = ["Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                   "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                   "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                   "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"]
    @resolution = [[10000, 12000], [500, 800], [15000, 20000], [100, 200]]
    @ip = ["63.29.38.211", "64.92.38.211", "14.92.38.300" "123.123.456"]
    @referrers = ['google', 'bing', 'yahoo', 'askjeeves', 'dogpile']
    @iterations = iterations
  end


  def generate
    client_registration_test

    @iterations.times do
      client_request_test
    end
  end

  def client_registration_test
    @client.each do |client|
      post '/sources', "identifier=#{client}&rootUrl=http://#{client}.com"
    end
  end

  def client_request_test
    @client.each do |client|
      @client_url.each_with_index do |iteration, index|

        payload_data = {"url": "http://#{client}.com/#{@client_url[index%4]}",
                      "requestedAt": "#{rand(2014..2015)}-#{rand(1..12)}-#{rand(1..30)} #{rand(0..24)}:#{rand(0..60)}:#{rand(0..60)} -#{rand(0..2400)}",
                      "respondedIn": @responded_in.rotate![0],
                      "referredBy": "http://#{@referrers.rotate![0]}.com",
                      "requestType": "#{@request_type[index%4]}",
                      "parameters": [],
                      "eventName": "#{@event_name[index%4]}",
                      "userAgent": "#{@user_agent}",
                      "resolutionWidth": "#{@resolution[index%4][0]}",
                      "resolutionHeight": "#{@resolution[index%4][1]}",
                      "ip": "#{@ip[index]}"}.to_json


                      post "/sources/#{client}/data", {payload: payload_data}
      end
    end
  end


end
