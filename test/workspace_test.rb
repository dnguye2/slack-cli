require_relative 'test_helper'
require_relative '../lib/workspace.rb'

describe "Workspace" do
  before do
    VCR.configuration.ignore_request { true }
    @workspace = Workspace.new
  end

  describe "select_user" do
    it "correctly selects a user by username" do
      def @workspace.get_user_input; "slackbot" end
      expect(@workspace.select_user).must_equal "slackbot has been selected"
    end

    it "correctly selects a user by slack_id" do
      def @workspace.get_user_input; "USLACKBOT" end
      expect(@workspace.select_user).must_equal "slackbot has been selected"
    end

    it "raises an error if user provided is not valid" do
      def @workspace.get_user_input; "notauser" end
      expect(@workspace.select_user).must_equal "User could not be found."
    end
  end

  describe "select_channel" do
    it "correctly selects a channel by channel name" do
      def @workspace.get_user_input; "random" end
      expect(@workspace.select_channel).must_equal "random has been selected"
    end
    
    it "correctly selects a channel by slack_id" do
      def @workspace.get_user_input; "CV7V4KYLF" end
      expect(@workspace.select_channel).must_equal "random has been selected"
    end

    it "raises a message if a channel could not be found" do
      def @workspace.get_user_input; "notachannel" end
      expect(@workspace.select_channel).must_equal "Channel could not be found."
    end
  end
end
