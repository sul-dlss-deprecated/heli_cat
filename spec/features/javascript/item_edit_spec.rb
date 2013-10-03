require "spec_helper"
feature "[me] link", js: true do
  scenario "should put the ID of the current user in the user field" do
    login_as "test-user"
    visit new_item_path
    find_field("item_user").value.should be_blank
    click_link "[me]"
    find_field("item_user").value.should eq "test-user"
  end
  scenario "should check the Purchased? checkbox when the Received? checkbox is checked" do
    login_as "test-user"
    visit new_item_path
    find("#item_received").should_not be_checked
    find("#item_purchased").should_not be_checked
    check "Received?"
    find("#item_received").should be_checked
    find("#item_purchased").should be_checked
  end
  scenario "should uncheck the Received? checkbox when the Purchase? checkbox is unchecked" do
    login_as "test-user"
    visit new_item_path
    find("#item_received").should_not be_checked
    find("#item_purchased").should_not be_checked
    check "Received?"
    find("#item_received").should be_checked
    find("#item_purchased").should be_checked
    uncheck "Purchased?"
    find("#item_received").should_not be_checked
    find("#item_purchased").should_not be_checked
  end
end