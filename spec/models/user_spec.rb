require "spec_helper"

describe User do
  describe NullUser do
    before :all do
      @user = User.new nil
    end
    it "should be returned when the id is nil" do
      @user.should be_a NullUser
    end
    it "should have the characteristics of a user" do
      @user.admin?.should be_false
      @user.equipment.should be_blank
    end
  end
end