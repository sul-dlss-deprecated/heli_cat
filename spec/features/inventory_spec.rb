require "spec_helper"

feature "Inventory" do
  fixtures :items
  scenario "should filter out staff categories when selected" do
    visit inventory_location_path
    expect(page).to have_selector "div.inventory-item", count: 10
    
    select "All Staff Equipment", from: "category"
    click_button "Filter Category"
    expect(page).to have_selector "div.inventory-item", count: 7

    select "Staff Computers", from: "category"
    click_button "Filter Category"
    expect(page).to have_selector "div.inventory-item", count: 6

    select "Staff Monitors", from: "category"
    click_button "Filter Category"
    expect(page).to have_selector "div.inventory-item", count: 1
    expect(page).to have_selector "h3 a", text: items(:monitor1).title

    select "Loaner Computers", from: "category"
    click_button "Filter Category"
    expect(page).to have_selector "div.inventory-item", count: 1
    expect(page).to have_selector "h3 a", text: items(:loaner1).title
  end
  scenario "should filter out lab categories when selected" do
    visit inventory_location_path
    expect(page).to have_selector "div.inventory-item", count: 10

    select "All Lab Equipment", from: "category"
    click_button "Filter Category"
    expect(page).to have_selector "div.inventory-item", count: 3

    select "Lab Computers", from: "category"
    click_button "Filter Category"
    expect(page).to have_selector "div.inventory-item", count: 1
    expect(page).to have_selector "h3 a", text: items(:lab_comp1).title

    select "Lab Monitors", from: "category"
    click_button "Filter Category"
    expect(page).to have_selector "div.inventory-item", count: 1
    expect(page).to have_selector "h3 a", text: items(:lab_monitor1).title

    select "Other Lab Equipment", from: "category"
    click_button "Filter Category"
    expect(page).to have_selector "div.inventory-item", count: 1
    expect(page).to have_selector "h3 a", text: items(:lab_camera1).title
  end
  scenario "should filter out the various Inventory types (Location, Department, etc.)" do
    visit inventory_location_path
    expect(page).to have_selector "div.inventory-item", count: 10
    
    fill_in "value", with: "Meyer 181"
    click_button "Filter Location"
    expect(page).to have_selector "div.inventory-item", count: 4
  end
  scenario "should be able to use both filters together" do
    visit inventory_location_path
    expect(page).to have_selector "div.inventory-item", count: 10

    select "Staff Computers", from: "category"
    click_button "Filter Category"
    expect(page).to have_selector "div.inventory-item", count: 6

    fill_in "value", with: "Meyer 210"
    click_button "Filter Location"
    expect(page).to have_selector "div.inventory-item", count: 3
  end
end