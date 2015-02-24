require "spec_helper"

feature "Purchasing New Equpment" do
  fixtures :purchase_options
  scenario "should display all of the Mac options" do
    purchase_a_mac
    [:retina, :air].each do |make|
      expect(page).to have_content(purchase_options(make).model)
      expect(page).to have_content(purchase_options(make).description)
    end
  end
  it "should display all of the PC options " do
    purchase_a_pc

    expect(page).to have_content(purchase_options(:dell).model)
    expect(page).to have_content(purchase_options(:dell).description)
  end
  it "should not mix options between makes" do
    purchase_a_mac

    expect(page).to_not have_content(purchase_options(:dell).model)
    expect(page).to_not have_content(purchase_options(:dell).description)

    purchase_a_pc

    [:retina, :air].each do |make|
      expect(page).to_not have_content(purchase_options(make).model)
      expect(page).to_not have_content(purchase_options(make).description)
    end
  end
  it "should not include any inactive purchase options" do
    purchase_a_mac

    expect(page).to_not have_content(purchase_options(:inactive).model)
    expect(page).to_not have_content(purchase_options(:inactive).description)
  end
  it "should inform a user of any pending purchase requests for them" do
    login_as "item-user"
    visit new_purchase_path
    expect(page).not_to have_content("You currently have 1 pending purchase.")
    item = Item.create( user: "item-user", received: false )

    visit new_purchase_path
    expect(page).to     have_content("You currently have 1 pending purchase.")
  end
  it "should autofill the new item form when a purchase option is selected" do
    purchase_a_mac
    retina = purchase_options(:retina)
    find("#option-#{retina.id}").click

    expect(page).to have_content("Add new item into the Inventory")
    expect(find_field("item_make").value).to eq retina.make
    expect(find_field("item_model").value).to eq retina.model
  end
end