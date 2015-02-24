require "spec_helper"

describe Item do
  describe "clone_for_swap!" do
    before :all do
      @purchase_option = PurchaseOption.create(make: "Mac", model: "15-inch MacBook Pro")
    end
    it "should add an Item" do
      item = Item.create(user: "admin-user", make: "Mac", model: "13-inch MacBook Pro", purchase_option: @purchase_option)
      expect(-> {item.clone_for_swap!}).to change{Item.count}.by(1)
    end
    it "should update the swap_item of the original item" do
      item = Item.create(user: "admin-user", make: "Mac", model: "13-inch MacBook Pro", purchase_option: @purchase_option)
      expect(item.swap_item).to be_nil
      item.clone_for_swap!
      expect(item.swap_item).to_not be_nil
    end
    it "should apply the specified data from the purchase option and origina litem ot the clone" do
      item = Item.create(user: "admin-user", department: "Webteam", location: "Meyer 182", make: "Mac", model: "13-inch MacBook Pro", purchase_option: @purchase_option)
      item.clone_for_swap!
      swap_item = Item.find(item.swap_item)
      expect(swap_item.user).to eq "admin-user"
      expect(swap_item.department).to eq "Webteam"
      expect(swap_item.location).to eq "Meyer 182"
      expect(swap_item.make).to eq "Mac"
      expect(swap_item.model).to eq "15-inch MacBook Pro"
    end
  end
  describe "title" do
    it "should return the user and model when available" do
      expect(Item.create(user: "jdoe",
                  model: "MacBookPro 15-inch - Retina",
                  make: "Mac",
                  department: "Webteam",
                  location: "Meyer 210").title).to eq "jdoe's MacBookPro 15-inch - Retina"
    end
    it "should return the user and make if available" do
      expect(Item.create(user: "jdoe", make: "Mac").title).to eq "jdoe's Mac"
    end
    it "should return the model and department if available" do
      expect(Item.create(model: "MacBookPro 17-inch", department: "Webteam").title).to eq "Webteam's MacBookPro 17-inch"
    end
    it "should return the model and location if available" do
      expect(Item.create(model: "MacBookPro 17-inch", location: "Meyer 210").title).to eq "MacBookPro 17-inch in Meyer 210"
    end
    it "should return the make and location if available" do
      expect(Item.create(make: "Dell", location: "Meyer 210").title).to eq "Dell in Meyer 210"
    end
    it "should return the model if it's the only thing available" do
      expect(Item.create(model: "MacBookPro 17-inch").title).to eq "MacBookPro 17-inch"
    end
    it "should return the make if it's the only thing available" do
      expect(Item.create(make: "Dell").title).to eq "Dell"
    end
    it "should return a friendly string if no meta-data is available" do
      item = Item.create
      expect(item.title).to eq "Inventory item #{item.id}"
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
        expect(-> { Item.create!(barcode: "1234")
             Item.create!(barcode: "1234")
           }).to raise_error ActiveRecord::RecordInvalid
      end
      it "should allow items w/ blank or nil barcodes to exist" do
        expect(-> { Item.create!(barcode: "")
             Item.create!(barcode: "")
           }).to_not raise_error
        expect(-> { Item.create!(barcode: nil)
             Item.create!(barcode: nil)
           }).to_not raise_error
      end
      it "should not allow a bad value in the swap_cycle_number" do
        expect(-> {Item.create!(swap_cycle_number: "10")}).to raise_error ActiveRecord::RecordInvalid
      end
      it "should not allow a bad value in the swap_cycle_span" do
        expect(-> {Item.create!(swap_cycle_span: "centuries")}).to raise_error ActiveRecord::RecordInvalid
      end
      it "should not allow badly formed swap_cycles" do
        expect(-> {Item.create!(swap_cycle: "100-years")}).to raise_error ActiveRecord::RecordInvalid
        expect(-> {Item.create!(swap_cycle: "5-centuries")}).to raise_error ActiveRecord::RecordInvalid
      end
    end
  end
end