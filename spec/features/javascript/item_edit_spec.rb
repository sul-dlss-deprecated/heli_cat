require "spec_helper"

feature "item add/edit form javascript", js: true do
  scenario "should put the ID of the current user in the user field" do
    login_as "test-user"
    visit new_item_path
    expect(find_field("item_user").value).to be_blank
    click_link "[me]"
    expect(find_field("item_user").value).to eq "test-user"
  end
  scenario "should check the Purchased? checkbox when the Received? checkbox is checked" do
    login_as_admin
    visit new_item_path
    expect(find("#item_received")).to_not be_checked
    expect(find("#item_purchased")).to_not be_checked
    check "Received?"
    expect(find("#item_received")).to be_checked
    expect(find("#item_purchased")).to be_checked
  end
  scenario "should uncheck the Received? checkbox when the Purchase? checkbox is unchecked" do
    login_as_admin
    visit new_item_path
    expect(find("#item_received")).to_not be_checked
    expect(find("#item_purchased")).to_not be_checked
    check "Received?"
    expect(find("#item_received")).to be_checked
    expect(find("#item_purchased")).to be_checked
    uncheck "Purchased?"
    expect(find("#item_received")).to_not be_checked
    expect(find("#item_purchased")).to_not be_checked
  end
  scenario "should pad the barcode with eight zeros once 2 digits are entered" do
    login_as "test-user"
    visit new_item_path
    expect(find("#item_barcode").value).to be_blank
    fill_in "item_barcode", with: "12"
    expect(find("#item_barcode").value).to eq "1200000000"
  end
  scenario "should toggle the tracking URL field when a shipping provider is selected" do
    login_as "test-user"
    visit new_item_path
    expect(page).to     have_selector("#item_tracking_url", visible: true)
    select "UPS", from: "item_shipping_provider"
    expect(page).not_to have_selector("#item_tracking_url", visible: true)
    select "Select...", from: "item_shipping_provider"
    expect(page).to     have_selector("#item_tracking_url", visible: true)
  end
  scenario "should display the Dell Express Service code when Dell is the make" do
    login_as "test-user"
    visit new_item_path
    expect(page).not_to have_selector("#item_express_service_code", visible: true)
    fill_in "item_make", with: "Dell"
    expect(page).to     have_selector("#item_express_service_code", visible: true)
    fill_in "item_make", with: "Anything Else"
    expect(page).not_to have_selector("#item_express_service_code", visible: true)
  end
end