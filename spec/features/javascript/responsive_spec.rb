require "spec_helper"

feature "Responsive Design", js: true do
  fixtures :items, :purchase_options
  scenario "Options sidebar should hide inventory navigation for smaller viewports." do
    item = items(:macbook1)
    login_as_admin
    visit edit_item_path item
    expect(page).to     have_selector("ul.responsive-collapse-nav", visible: true)
    page.driver.resize("766", "500")
    expect(page).not_to have_selector("ul.responsive-collapse-nav", visible: true)
    page.driver.resize("1024", "500")
    expect(page).to     have_selector("ul.responsive-collapse-nav", visible: true)
  end
  scenario "Options sidebar should have functional toggle button on smaller screens" do
    item = items(:macbook1)
    login_as_admin

    visit edit_item_path item
    expect(page).to     have_selector("ul.responsive-collapse-nav", visible: true)
    expect(page).not_to have_selector("[data-behavior='responsive-collapse-toggle']", visible: true)

    page.driver.resize("766", "500")
    expect(page).not_to have_selector("ul.responsive-collapse-nav", visible: true)
    expect(page).to     have_selector("[data-behavior='responsive-collapse-toggle']", visible: true)
    expect(page).to     have_selector("[data-behavior='responsive-collapse-toggle'] i.icon-plus")

    find("[data-behavior='responsive-collapse-toggle']").click
    expect(page).to     have_selector("ul.responsive-collapse-nav", visible: true)
    expect(page).to     have_selector("[data-behavior='responsive-collapse-toggle'] i.icon-minus")

    find("[data-behavior='responsive-collapse-toggle']").click
    expect(page).not_to have_selector("ul.responsive-collapse-nav", visible: true)

    page.driver.resize("1024", "500")
    expect(page).to     have_selector("ul.responsive-collapse-nav", visible: true)
    expect(page).not_to have_selector("[data-behavior='responsive-collapse-toggle'] i.icon-minus", visible: true)
    expect(page).not_to have_selector("[data-behavior='responsive-collapse-toggle'] i.icon-plus", visible: true)
  end
  scenario "should hide the purcahse option number heading" do
    purchase_a_mac
    expect(page).to     have_selector("h3", text: "1)", visible: true)
    page.driver.resize("766", "500")
    expect(page).not_to have_selector("h3", text: "1)", visible: true)
    page.driver.resize("1024", "500")
    expect(page).to     have_selector("h3", text: "1)", visible: true)
  end
end