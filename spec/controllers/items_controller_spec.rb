require "spec_helper"

describe ItemsController do
  before :each do
    request.env["HTTP_REFERER"] = "http://www.example.com/"
  end
  describe "authorization" do
    describe "of anonymous users" do
      it "should not protect the find action" do
        get :find
        response.should be_success
      end
      it "should not protect the show action" do
        get :show, id: Item.create.id
        response.should be_success
      end
      it "should protect the edit action" do
        -> { get :edit, id: Item.create.id }.should raise_error User::NotAuthorized
      end
      it "should protect the update action" do
        -> { get :update, id: Item.create.id }.should raise_error User::NotAuthorized
      end
      it "should protect the destroy action" do
        -> { get :destroy, id: Item.create.id }.should raise_error User::NotAuthorized
      end
      it "should protect the swap action" do
        -> { get :swap, id: Item.create.id }.should raise_error User::NotAuthorized
      end
      it "should protect the choose_swap action" do
        -> { get :choose_swap, id: Item.create.id }.should raise_error User::NotAuthorized
      end
      it "should protect the change_swap_model action" do
        -> { get :change_swap_model, id: Item.create.id }.should raise_error User::NotAuthorized
      end
      it "should protect the create_swap_record action" do
        -> { get :create_swap_record, id: Item.create.id }.should raise_error User::NotAuthorized
      end
      it "should protect the do_swap action" do
        -> { get :do_swap, id: Item.create.id }.should raise_error User::NotAuthorized
      end
    end

    describe "of admin users" do
      before :each do
        controller.stub(:current_user).and_return(admin_user)
      end
      it "should allow access to the create action" do
        get :create, item: {user: "admin-user", model: "MacBook Pro"}
        flash[:success].should == "admin-user's MacBook Pro was succesfully added!"
        response.should be_redirect
      end
      it "should allow access to the edit action" do
        get :edit, id: Item.create.id
        response.should be_success
      end
      it "should allow access to the update action" do
        get :update, id: Item.create.id, item: {user: "admin-user", model: "MacBook Pro"}
        flash[:success].should == "admin-user's MacBook Pro was succesfully updated!"
        response.should be_redirect
      end
      it "should allow access to the destroy action" do
        get :destroy, id: Item.create.id
        flash[:notice].should =~ / removed from the inventory.$/
        response.should be_redirect
      end
      it "should allow access to the swap action" do
        get :swap, id: Item.create.id
        response.should be_success
      end
      it "should allow access to the choose_swap action" do
        get :choose_swap, id: Item.create.id
        response.should be_success
      end
      it "should allow access to the change_swap_model action" do
        get :change_swap_model, id: Item.create.id, purchase_option_id: PurchaseOption.create.id
        flash[:success].should =~ /swap model updated/
        response.should be_redirect
      end
      it "should allow access to the create_swap_record action" do
        item = Item.create
        item.purchase_option = PurchaseOption.create
        get :create_swap_record, id: item.id
        flash[:success].should =~ /has been added to the inventory to replace/
        response.should be_redirect
      end
      it "should allow access to the do_swap action" do
        get :do_swap, id: Item.create.id, swap_id: Item.create.id
        flash[:success].should =~ /^.* removed as user of .* and .* swapped in its place\.$/
        response.should be_redirect
      end
    end
    describe "of item owners" do
      before :each do
        controller.stub(:current_user).and_return(item_owner)
      end
      it "should allow access to the edit action" do
        get :edit, id: Item.create(user: "item-owner").id
        response.should be_success
      end
      it "should allow access to the update action" do
        get :update, id: Item.create(user: "item-owner").id, item: {user: "admin-user", model: "MacBook Pro"}
        flash[:success].should == "admin-user's MacBook Pro was succesfully updated!"
        response.should be_redirect
      end
      it "should allow access to the destroy action" do
        get :destroy, id: Item.create(user: "item-owner").id
        flash[:notice].should =~ / removed from the inventory.$/
        response.should be_redirect
      end
      it "should allow access to the choose_swap action" do
        get :choose_swap, id: Item.create(user: "item-owner").id
        response.should be_success
      end
      it "should allow access to the change_swap_model action" do
        get :change_swap_model, id: Item.create(user: "item-owner").id, purchase_option_id: PurchaseOption.create.id
        flash[:success].should =~ /swap model updated/
        response.should be_redirect
      end
      it "should protect access to the do_swap action" do
        -> { get :do_swap, id: Item.create(user: "item-owner").id, swap_id: Item.create.id }.should raise_error User::NotAuthorized
      end
      it "should protect access to the create_swap_record action" do
        -> { get :create_swap_record, id: Item.create(user: "item-owner").id }.should raise_error User::NotAuthorized
      end
      it "should protect access to the swap action" do
        -> { get :swap, id: Item.create(user: "item-owner").id }.should raise_error User::NotAuthorized
      end
    end
  end
  describe "do_swap" do
    before :each do
      controller.stub(:current_user).and_return(admin_user)
      @item = Item.create(user: "old-item-user", category: "staff_computer")
      @swap_item = Item.create
    end
    it "should remove the user from the old inventory item" do
      Item.find(@item.id).user.should == "old-item-user"
      get :do_swap, id: @item.id, swap_id: @swap_item.id
      old_item = Item.find(@item.id)
      old_item.category.should eq "loaner_computer"
      old_item.user.should be_blank
    end
    it "should put the old inventory item into the Loaner Computer category" do
      Item.find(@item.id).category.should == "staff_computer"
      get :do_swap, id: @item.id, swap_id: @swap_item.id
      old_item = Item.find(@item.id)
      old_item.category.should eq "loaner_computer"
    end
    it "should redirect to the swap item's edit path" do
      get :do_swap, id: @item.id, swap_id: @swap_item.id
      response.should redirect_to edit_item_path(@swap_item)
    end
  end
end