require "spec_helper"

feature "Responsive Design", js: true do
  fixtures :items
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
end