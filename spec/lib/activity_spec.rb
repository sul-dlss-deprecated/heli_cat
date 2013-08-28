require "spec_helper"

describe Tracking::Activity do
  before :all do
    @block_tracking = Tracking::Activity.new do
      location    "LOCATION"
      description "DESCRIPTION"
      date        "2013-09-23"
      time        "082200"
    end
    @hash_tracking = Tracking::Activity.new(location:    "LOCATION",
                                            description: "DESCRIPTION",
                                            date:        "2013-09-23",
                                            time:        "082200")
  end
  describe "initialization" do
    it "should handle the intended block style syntax" do
      @block_tracking.location.should    == "LOCATION"
      @block_tracking.description.should == "DESCRIPTION"
      @block_tracking.date.should        == Date.parse("2013-09-23")
      @block_tracking.time.should        == "8:22am"
    end
    it "should handle the intended hash style syntax" do
      @hash_tracking.location.should    == "LOCATION"
      @hash_tracking.description.should == "DESCRIPTION"
      @hash_tracking.date.should        == Date.parse("2013-09-23")
      @hash_tracking.time.should        == "8:22am"
    end
    it "should raise an error if a bad attribute is passed in the block syntax" do
      -> { Tracking::Activity.new do
             not_an_attribute "Error"
           end }.should raise_error NoMethodError
    end
    it "should raise an error if a bad attribute is passed in the hash syntax" do
      -> { Tracking::Activity.new(not_an_attribute: "Error") }.should raise_error NoMethodError
    end
  end
  describe "to_s" do
    it "should respond to #to_s with the constructed activity" do
      @block_tracking.to_s.should == "2013-09-23 (8:22am): DESCRIPTION @ LOCATION"
    end
    it "should have the same #to_s regardless of initialization method" do
      @hash_tracking.to_s.should == @block_tracking.to_s
    end
  end
end