require "spec_helper"

feature "My Equipment" do
  fixtures :items
  scenario "displays equipment for the current user" do
    login_as "jdoe1", admin?: false
    visit root_path
    click_link "My equipment (2)"

    [:macbook1, :not_received].each do |key|
      computer = items(key)
      expect(page).to have_content computer.title
    end
  end
end