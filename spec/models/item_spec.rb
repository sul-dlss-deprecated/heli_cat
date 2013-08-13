require "spec_helper"

describe Item do
  describe "clone_for_swap!" do
    before :all do
      @purchase_option = PurchaseOption.create(make: "Mac", model: "15-inch MacBook Pro")
    end
    it "should add an Item" do
      item = Item.create(user: "admin-user", make: "Mac", model: "13-inch MacBook Pro", purchase_option: @purchase_option)
      -> {item.clone_for_swap!}.should change{Item.count}.by(1)
    end
    it "should update the swap_item of the original item" do
      item = Item.create(user: "admin-user", make: "Mac", model: "13-inch MacBook Pro", purchase_option: @purchase_option)
      item.swap_item.should be_nil
      item.clone_for_swap!
      item.swap_item.should_not be_nil
    end
    it "should apply the specified data from the purchase option and origina litem ot the clone" do
      item = Item.create(user: "admin-user", department: "Webteam", location: "Meyer 182", make: "Mac", model: "13-inch MacBook Pro", purchase_option: @purchase_option)
      item.clone_for_swap!
      swap_item = Item.find(item.swap_item)
      swap_item.user.should == "admin-user"
      swap_item.department.should == "Webteam"
      swap_item.location.should == "Meyer 182"
      swap_item.make.should == "Mac"
      swap_item.model.should == "15-inch MacBook Pro"
    end
  end
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
    describe "validations" do
      it "should not allow a bad value in the swap_cycle_number" do
        -> {Item.create!(swap_cycle_number: "10")}.should raise_error ActiveRecord::RecordInvalid
      end
      it "should not allow a bad value in the swap_cycle_span" do
        -> {Item.create!(swap_cycle_span: "centuries")}.should raise_error ActiveRecord::RecordInvalid
      end
      it "should not allow badly formed swap_cycles" do
        -> {Item.create!(swap_cycle: "100-years")}.should raise_error ActiveRecord::RecordInvalid
        -> {Item.create!(swap_cycle: "5-centuries")}.should raise_error ActiveRecord::RecordInvalid
      end
    end
  end
end