require "spec_helper"

feature "Swapping an item in the inventory" do
  fixtures :items, :purchase_options
  scenario "choosing a swap model as a user" do
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
    
    login_as_admin
    visit item_path item
    click_button "Create Swap Record"
    expect(page).to have_content("#{swap_model.model} has been added to the inventory to replace #{item.title}.")

    visit item_path item
    click_link "Swap"
    expect(page).to have_content("Which piece of equipment are you swapping #{item.title} with?")

    find("#swap-item-0").click
    expect(page).to have_content(/#{item.user} removed as user of .* and .* swapped in its place/)
    expect(Item.find(item.id).user).to be_nil
  end
  
end