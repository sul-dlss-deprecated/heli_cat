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
end