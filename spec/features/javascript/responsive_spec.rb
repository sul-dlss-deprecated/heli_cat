require "spec_helper"

feature "Responsive Design", js: true do
  fixtures :items, :purchase_options
  scenario "Options sidebar should hide inventory navigation for smaller viewports." do
    item = items(:macbook1)
    login_as_admin
    visit edit_item_path item
    expect(page).to have_selector("[data-toggle='filter-by']", visible: true)
    page.driver.resize("766", "500")
    expect(page).not_to have_selector("[data-toggle='filter-by']", visible: true)
    page.driver.resize("1024", "500")
    expect(page).to have_selector("[data-toggle='filter-by']", visible: true)
  end
  scenario "should hide the purcahse option number heading" do
    purchase_a_mac
    find("h3", text: "1)").should be_visible
    page.driver.resize("766", "500")
    expect(page).not_to have_selector("h3", text: "1)", visible: true)
    page.driver.resize("1024", "500")
    find("h3", text: "1)").should be_visible
  end
end