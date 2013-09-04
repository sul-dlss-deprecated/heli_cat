module Features
  module NavigationHelpers
    def purchase_a_mac
      visit root_path
      click_link "Purchase new equipment"
      click_link "Mac"
    end
    def purchase_a_pc
      visit root_path
      click_link "Purchase new equipment"
      click_link "PC"
    end
  end
end