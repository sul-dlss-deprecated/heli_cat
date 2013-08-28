require "spec_helper"

describe Tracking do
  describe "shipping provider casting" do
    it "should return the proper tracking provider class" do
      Tracking.new(Item.create(shipping_provider: "UPS", tracking_number: "123456")).should be_a Tracking::UPS
    end
  end
  describe "Errors" do
    before :all do
      @unknown_provider = Item.create(shipping_provider: "not-a-known-provider")
    end
    it "should be raised if an unknown shipping provider is requested" do
      -> { Tracking.new @unknown_provider }.should raise_error(Tracking::UnknownProvider)
    end
  end
end