require "spec_helper"

describe User do
  describe NullUser do
    before :all do
      @user = User.new nil
    end
    it "should be returned when the id is nil" do
      expect(@user).to be_a NullUser
    end
    it "should have the characteristics of a user" do
      expect(@user.admin?).to be_falsey
      expect(@user.equipment).to be_blank
    end
  end
end