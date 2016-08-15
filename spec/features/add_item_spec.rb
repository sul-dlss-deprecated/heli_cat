require "spec_helper"

feature "Adding an Item to the Inventory" do
  scenario "should be possible as an admin" do
    login_as_admin
    visit inventory_location_path
    click_link "Add Item"
    expect(page).to have_content("Add new item into the Inventory")
    fill_in "item_user", with: "not-a-real-user"
    fill_in "item_make", with: "Mac"
    fill_in "item_model", with: "MacBookPro"
    click_button("Save")

    expect(page).to have_content "not-a-real-user's MacBookPro was succesfully added!"
  end
  scenario "should have a hidden field representing the 'Send Email?' option" do
    login_as "test-user"
    visit new_item_path
    expect(page).not_to have_selector("input#send_email[type='checkbox']")
    expect(page).to     have_selector("input#send_email[type='hidden']", visible: false)
  end
  scenario "should present admin users with a 'Send Email?' option" do
    login_as_admin
    visit new_item_path
    expect(page).to     have_selector("input#send_email[type='checkbox']")
    expect(page).not_to have_selector("input#send_email[type='hidden']")
  end
  scenario "should not automatically send an email for admin users" do
    login_as_admin
    visit new_item_path
    fill_in "item_user", with: "test-user"
    fill_in "item_make", with: "Mac"
    fill_in "item_model", with: "New MacBook Pro - Retina"
    expect(-> {click_button("Save")}).to_not change{ActionMailer::Base.deliveries.count}
  end
  scenario "should send an email for admin users when requested" do
    login_as_admin
    visit new_item_path
    fill_in "item_user", with: "test-user"
    fill_in "item_make", with: "Mac"
    fill_in "item_model", with: "New MacBook Pro - Retina"
    check "Send email?"
    expect(-> {click_button("Save")}).to change{ActionMailer::Base.deliveries.count}.by(1)
  end
  scenario "should automatically send an email for non-admin users" do
    login_as "test-user"
    visit new_item_path
    fill_in "item_user", with: "test-user"
    fill_in "item_make", with: "Mac"
    fill_in "item_model", with: "New MacBook Pro - Retina"
    expect(-> {click_button("Save")}).to change{ActionMailer::Base.deliveries.count}.by(1)
  end
end
