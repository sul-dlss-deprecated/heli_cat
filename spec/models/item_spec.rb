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
  describe "title" do
    it "should return the user and model when available" do
      Item.create(user: "jdoe",
                  model: "MacBookPro 15-inch - Retina",
                  make: "Mac",
                  department: "Webteam",
                  location: "Meyer 210").title.should == "jdoe's MacBookPro 15-inch - Retina"
    end
    it "should return the user and make if available" do
      Item.create(user: "jdoe", make: "Mac").title.should == "jdoe's Mac"
    end
    it "should return the model and department if available" do
      Item.create(model: "MacBookPro 17-inch", department: "Webteam").title.should == "Webteam's MacBookPro 17-inch"
    end
    it "should return the model and location if available" do
      Item.create(model: "MacBookPro 17-inch", location: "Meyer 210").title.should == "MacBookPro 17-inch in Meyer 210"
    end
    it "should return the make and location if available" do
      Item.create(make: "Dell", location: "Meyer 210").title.should == "Dell in Meyer 210"
    end
    it "should return the model if it's the only thing available" do
      Item.create(model: "MacBookPro 17-inch").title.should == "MacBookPro 17-inch"
    end
    it "should return the make if it's the only thing available" do
      Item.create(make: "Dell").title.should == "Dell"
    end
    it "should return a friendly string if no meta-data is available" do
      item = Item.create
      item.title.should == "Inventory item #{item.id}"
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
      it "should not allow two items w/ the same barcode to exist" do
        -> { Item.create!(barcode: "1234")
             Item.create!(barcode: "1234")
           }.should raise_error ActiveRecord::RecordInvalid
      end
      it "should allow items w/ blank or nil barcodes to exist" do
        -> { Item.create!(barcode: "")
             Item.create!(barcode: "")
           }.should_not raise_error
        -> { Item.create!(barcode: nil)
             Item.create!(barcode: nil)
           }.should_not raise_error
      end
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