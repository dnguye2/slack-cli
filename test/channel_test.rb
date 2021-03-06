require_relative 'test_helper'
require_relative '../lib/channel'

describe "Channel" do
  describe "self.get" do
    it "gets a list of channels" do
      result = {}

      # make an API call
      VCR.use_cassette("channels-list-endpoint") do
          # call method you intend to use
          result = Channel.get("https://slack.com/api/channels.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true

    end

    it "raises an error when a call fails" do
      VCR.use_cassette("channels-list-endpoint") do
        # call method you intend to use
        expect {Channel.get("https://slack.com/api/bogus.endpoint")}.must_raise SlackAPIError
      end
    end
  end

  describe "self.list_all" do
    it "returns a valid list of channels" do
      result = []

      VCR.use_cassette("channels-list-endpoint") do
        result = Channel.list_all
      end
      
      expect(result).must_be_kind_of Array
      expect(result.length).must_be :>, 0
      result.each do |channel|
        expect(channel).must_be_kind_of Channel
      end
    end
  end
end