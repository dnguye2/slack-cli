require "httparty"
require 'dotenv'

Dotenv.load

class Recipient
  
  attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end

  def send_message(text)
    response = HTTParty.post("https://slack.com/api/chat.postMessage", 
                              query: {token: ENV['SLACK_TOKEN'], 
                              channel: self.slack_id, 
                              text: text})
    if response.code != 200 || response["ok"] == false
      raise SlackAPIError, "We encountered a problem: #{response["error"]}"
    end
  end

  def details
    # implement in child class
  end


# =====Class methods=====

# gets url, based off of API documentation
 def self.get(url)
  # send message using HTTParty
  response = HTTParty.get(url, query: {token: ENV['SLACK_TOKEN']})

  # accounting for errors
  # slack still gives 200 code
  if response.code != 200 || response["ok"] == false
    raise SlackAPIError, "We encountered a problem: #{response["error"]}"
  end

  return response
 end

 def self.list_all
  # to be defined in a child class
 end

end


class SlackAPIError < Exception
end
