require "spec_helper"
require "fixtures/ups_responses"
include UPSResponses
def config
  YAML.load_file("#{Rails.root}/config/UPS.yml")[Rails.env]
end

describe Tracking::UPS do
  describe "activity" do
    before :all do
      @tracking = Tracking::UPS.new "123456"
    end
    it "should return a Tracking::Activity object" do
      @tracking.should_receive(:response).and_return(multiple_activities)
      @tracking.activity.each do |activity|
        activity.should be_a Tracking::Activity
      end
    end
    it "should parse the date correctly" do
      @tracking.should_receive(:response).and_return(standard_response)
      activity = @tracking.activity
      activity.length.should == 1
      date = activity.first.date
      date.should be_a Date
      date.should == Date.parse("2013-01-05")
    end
    it "should parse the time correctly" do
      @tracking.should_receive(:response).and_return(multiple_activities)
      activity = @tracking.activity
      activity.length.should == 2
      deliver_time = activity.first.time
      shipment_time = activity.last.time
      deliver_time.should == "8:22am"
      shipment_time.should == "10:15pm"
    end
    it "should return multiple activities correctly" do
      @tracking.should_receive(:response).and_return(multiple_activities)
      activity = @tracking.activity
      activity.length.should == 2
      activity.map do |act|
        act.to_s
      end.should == ["2013-01-05 (8:22am): DELIVERED @ Stanford, CA",
                     "2013-01-01 (10:15pm): SHIPPED @ Originating City, CA"]
    end
  end
  describe "request_xml" do
    before :all do
      @tracking_number = "123456"
      @request_xml = Tracking::UPS.new(@tracking_number).send(:request_xml)
    end
    it "should include the appropriate request options" do
      @request_xml.should match /<RequestAction>Track<\/RequestAction>/
      @request_xml.should match /<RequestOption>activity<\/RequestOption>/
    end
    it "should include the UPS account credentials" do
      @request_xml.should match /<AccessLicenseNumber>#{config["access_license_number"]}<\/AccessLicenseNumber>/
      @request_xml.should match /<UserId>#{config["user_id"]}<\/UserId>/
      @request_xml.should match /<Password>#{config["password"]}<\/Password>/
    end
    it "should include the tracking number" do
      @request_xml.should match /<TrackingNumber>#{@tracking_number}<\/TrackingNumber>/
    end
  end
end