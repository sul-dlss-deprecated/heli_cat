require "spec_helper"

describe ItemsController do
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
      it "should protect the request_swap_purchase action" do
        -> { get :request_swap_purchase, id: Item.create.id }.should raise_error User::NotAuthorized
      end
      it "should protect the do_swap action" do
        -> { get :do_swap, id: Item.create.id }.should raise_error User::NotAuthorized
      end
    end

    describe "of admin users" do
      before :each do
        controller.stub(:current_user).and_return(admin_user)
        request.env["HTTP_REFERER"] = "http://www.example.com/"
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
      it "should allow access to the request_swap_purchase action" do
        item = Item.create
        item.purchase_option = PurchaseOption.create
        get :request_swap_purchase, id: item.id
        flash[:success].should =~ /The purchase of a .* to replace .* has been initiated./
        response.should be_redirect
      end
      it "should allow access to the request_swap_purchase action" do
        get :do_swap, id: Item.create.id, swap_id: "1"
        flash[:success].should =~ /removed from the inventory and .* swapped in its place/
        response.should be_redirect
      end
    end
    describe "of item owners" do
      before :each do
        controller.stub(:current_user).and_return(item_owner)
        request.env["HTTP_REFERER"] = "http://www.example.com/"
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
      it "should allow access to the swap action" do
        get :swap, id: Item.create(user: "item-owner").id
        response.should be_success
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
      it "should allow access to the request_swap_purchase action" do
        item = Item.create(user: "item-owner")
        item.purchase_option = PurchaseOption.create
        get :request_swap_purchase, id: item.id
        flash[:success].should =~ /The purchase of a .* to replace .* has been initiated./
        response.should be_redirect
      end
      it "should allow access to the request_swap_purchase action" do
        get :do_swap, id: Item.create(user: "item-owner").id, swap_id: "1"
        flash[:success].should =~ /removed from the inventory and .* swapped in its place/
        response.should be_redirect
      end
    end
  end
end