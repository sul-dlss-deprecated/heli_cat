require "spec_helper"
feature "[me] link", js: true do
  scenario "should put the ID of the current user in the user field" do
    login_as "test-user"
    visit new_item_path
    find_field("item_user").value.should be_blank
    click_link "[me]"
    find_field("item_user").value.should eq "test-user"
  end
end