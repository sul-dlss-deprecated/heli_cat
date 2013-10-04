require "spec_helper"

feature "item add/edit form javascript", js: true do
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
  scenario "should pad the barcode with eight zeros once 2 digits are entered" do
    login_as "test-user"
    visit new_item_path
    find("#item_barcode").value.should be_blank
    fill_in "item_barcode", with: "12"
    find("#item_barcode").value.should eq "1200000000"
  end
  scenario "should toggle the tracking URL field when a shipping provider is selected" do
    login_as "test-user"
    visit new_item_path
    find("#item_tracking_url").should be_visible
    select "UPS", from: "item_shipping_provider"
    # weird syntax necessary to get Capybara to wait for the element to dissapear.
    expect(page).not_to have_selector("#item_tracking_url", visible: true)
    select "Select...", from: "item_shipping_provider"
    find("#item_tracking_url").should be_visible
  end
  scenario "should display the Dell Express Service code when Dell is the make" do
    login_as "test-user"
    visit new_item_path
    expect(page).not_to have_selector("#item_express_service_code", visible: true)
    fill_in "item_make", with: "Dell"
    find("#item_express_service_code").should be_visible
    fill_in "item_make", with: "Anything Else"
    expect(page).not_to have_selector("#item_express_service_code", visible: true)
  end
end