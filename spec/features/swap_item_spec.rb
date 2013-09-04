require "spec_helper"

feature "Swapping an item in the inventory" do
  fixtures :items, :purchase_options
  scenario "choosing a swap model, requesting, and " do
    item = items(:macbook1)
    swap_model = purchase_options(:air)
    login_as item.user
    visit item_path item
    click_link "Choose Swap Model"

    expect(page).to have_content("Please choose a model to swap")
    [:retina, :air].each do |make|
      expect(page).to have_content(purchase_options(make).model)
      expect(page).to have_content(purchase_options(make).description)
    end
    find("#swap-model-#{swap_model.id}").click
    expect(page).to have_content("#{item.title} swap model updated")
    expect(page).to have_content("Swap Model: #{swap_model.model}")

    visit item_path item
    click_button "Request Swap Purchase"
    expect(page).to have_content("#{swap_model.model} to replace #{item.title} has been initiated.")

    visit item_path item
    click_link "Swap"
    expect(page).to have_content("Which piece of equipment are you swapping #{item.title} with?")

    click_button "Swap"
    expect(page).to have_content("#{item.title} removed from the inventory and ")
    -> { Item.find(item.id) }.should raise_error ActiveRecord::RecordNotFound
  end
end