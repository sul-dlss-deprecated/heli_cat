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
      expect(@block_tracking.location).to    eq "LOCATION"
      expect(@block_tracking.description).to eq "DESCRIPTION"
      expect(@block_tracking.date).to        eq Date.parse("2013-09-23")
      expect(@block_tracking.time).to        eq "8:22am"
    end
    it "should handle the intended hash style syntax" do
      expect(@hash_tracking.location).to    eq "LOCATION"
      expect(@hash_tracking.description).to eq "DESCRIPTION"
      expect(@hash_tracking.date).to        eq Date.parse("2013-09-23")
      expect(@hash_tracking.time).to        eq "8:22am"
    end
    it "should raise an error if a bad attribute is passed in the block syntax" do
      expect(-> { Tracking::Activity.new do
                    not_an_attribute "Error"
                  end }).to raise_error NoMethodError
    end
    it "should raise an error if a bad attribute is passed in the hash syntax" do
      expect(-> { Tracking::Activity.new(not_an_attribute: "Error") }).to raise_error NoMethodError
    end
  end
  describe "to_s" do
    it "should respond to #to_s with the constructed activity" do
      expect(@block_tracking.to_s).to eq "2013-09-23 (8:22am): DESCRIPTION @ LOCATION"
    end
    it "should have the same #to_s regardless of initialization method" do
      expect(@hash_tracking.to_s).to eq @block_tracking.to_s
    end
  end
end