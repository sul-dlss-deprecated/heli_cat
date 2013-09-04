require "spec_helper"

feature "Updating an item in the inventory" do
  fixtures :items
  scenario "should be possible by an admin" do
    item = items(:macbook1)
    new_location = "Meyer 210"
    item.location.should_not eq new_location
    
    login_as_admin
    visit item_path(item)
    click_link "Edit"

    expect(page).to have_content("Editing #{item.title}")
    find_field("item_location").value.should eq item.location

    fill_in "item_location", with: new_location
    click_button "Save"

    expect(page).to have_content("#{item.title} was succesfully updated!")
    find_field("item_location").value.should eq new_location
  end
  scenario "should be possible by an item ownder" do
    item = items(:macbook2)
    new_location = "Meyer 181"
    item.location.should_not eq new_location

    login_as item.user
    visit item_path(item)
    click_link "Edit"

    expect(page).to have_content("Editing #{item.title}")
    find_field("item_location").value.should eq item.location

    fill_in "item_location", with: new_location
    click_button "Save"

    expect(page).to have_content("#{item.title} was succesfully updated!")
    find_field("item_location").value.should eq new_location
  end
end