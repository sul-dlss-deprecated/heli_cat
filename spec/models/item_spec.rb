require "spec_helper"

describe Item do
  describe "swap_cycle" do
    it "should get the number set by swap_cycle_number" do
      item = Item.create!(swap_cycle_number: "4")
      expect(item.swap_cycle).to eq "4-"
    end
    it "should get the span set by swap_cycle_span" do
      item = Item.create!(swap_cycle_span: "years")
      expect(item.swap_cycle).to eq "-years"
    end
    it "should set the entire swap_cycle when both number and span elements are present" do
      item = Item.create!(swap_cycle_number: "3", swap_cycle_span: "years")
      expect(item.swap_cycle).to eq "3-years"
    end
  end
end