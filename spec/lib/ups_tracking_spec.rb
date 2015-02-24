require "spec_helper"
require "fixtures/ups_responses"
include UPSResponses

describe Tracking::UPS do
  let(:config) { {"access_license_number" => "ABC", "user_id" => "DEF", "password" => "GEH"} }
  before :each do
    Tracking::UPS.any_instance.stub(:config).and_return(config)
  end
  describe "activity" do
    before :all do
      @tracking = Tracking::UPS.new "123456"
    end
    it "should return a Tracking::Activity object" do
      @tracking.should_receive(:response).and_return(multiple_activities)
      @tracking.activity.each do |activity|
        expect(activity).to be_a Tracking::Activity
      end
    end
    it "should parse the date correctly" do
      @tracking.should_receive(:response).and_return(standard_response)
      activity = @tracking.activity
      expect(activity.length).to eq 1
      date = activity.first.date
      expect(date).to be_a Date
      expect(date).to eq Date.parse("2013-01-05")
    end
    it "should parse the time correctly" do
      @tracking.should_receive(:response).and_return(multiple_activities)
      activity = @tracking.activity
      expect(activity.length).to eq 2
      deliver_time = activity.first.time
      shipment_time = activity.last.time
      expect(deliver_time).to eq "8:22am"
      expect(shipment_time).to eq "10:15pm"
    end
    it "should return multiple activities correctly" do
      @tracking.should_receive(:response).and_return(multiple_activities)
      activity = @tracking.activity
      expect(activity.length).to eq 2
      expect(activity.map(&:to_s)).to eq ["2013-01-05 (8:22am): DELIVERED @ Stanford, CA", "2013-01-01 (10:15pm): SHIPPED @ Originating City, CA"]
    end
  end
  describe "request_xml" do
    # needs to be 'before :each' so we get the any_instance stub
    before :each do
      @tracking_number = "123456"
      @request_xml = Tracking::UPS.new(@tracking_number).send(:request_xml)
    end
    it "should include the appropriate request options" do
      expect(@request_xml).to match /<RequestAction>Track<\/RequestAction>/
      expect(@request_xml).to match /<RequestOption>activity<\/RequestOption>/
    end
    it "should include the UPS account credentials" do
      expect(@request_xml).to match /<AccessLicenseNumber>#{config["access_license_number"]}<\/AccessLicenseNumber>/
      expect(@request_xml).to match /<UserId>#{config["user_id"]}<\/UserId>/
      expect(@request_xml).to match /<Password>#{config["password"]}<\/Password>/
    end
    it "should include the tracking number" do
      expect(@request_xml).to match /<TrackingNumber>#{@tracking_number}<\/TrackingNumber>/
    end
  end
end