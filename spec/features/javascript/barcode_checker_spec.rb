require "spec_helper"

feature "barcode uniqueness ajax requests", js: true do
  fixtures :items
  scenario "should indicate a unique barcode in a new item form" do
    login_as "test-user"
    visit new_item_path

    # status indicator should be 'X'
    expect(page).not_to have_selector("i.icon-ok")
    expect(page).to     have_selector("i.icon-remove")

    fill_in :item_barcode, with: "121234"
    expect(find("#item_barcode").value).to eq "12000000001234"

    # status indicator should be the checkmark
    expect(page).to     have_selector("i.icon-ok")
    expect(page).not_to have_selector("i.icon-remove")
  end
  scenario "should indicate a duplicate barcode in a new item form" do
    login_as "test-user"
    visit new_item_path

    # status indicator should be 'X'
    expect(page).not_to have_selector("i.icon-ok")
    expect(page).to     have_selector("i.icon-remove")

    barcode = items(:macbook1).barcode
    fill_in :item_barcode, with: "#{barcode[0..1]}#{barcode[-4,4]}"
    expect(find("#item_barcode").value).to eq barcode

    # status indicator should be 'X'
    expect(page).not_to have_selector("i.icon-ok",     visible: true)
    expect(page).to     have_selector("i.icon-remove", visible: true)
  end
  scenario "should indicate a unique barcode in an updated item form" do
    login_as_admin
    visit edit_item_path(items(:macbook1))

    # status indicator should be the checkmark
    expect(page).to     have_selector("i.icon-ok")
    expect(page).not_to have_selector("i.icon-remove")
  
    fill_in :item_barcode, with: "121234"
    expect(find("#item_barcode").value).to eq "12000000001234"

    # status indicator should be the checkmark
    expect(page).to     have_selector("i.icon-ok",     visible: true)
    expect(page).not_to have_selector("i.icon-remove", visible: true)
  end
  scenario "should indicate a duplicate barcode in an update item form" do
    login_as_admin
    visit edit_item_path(items(:macbook2))

    # status indicator should be the checkmark
    expect(page).to     have_selector("i.icon-ok")
    expect(page).not_to have_selector("i.icon-remove")

    barcode = items(:macbook1).barcode
    fill_in :item_barcode, with: "#{barcode[0..1]}#{barcode[-4,4]}"
    expect(find("#item_barcode").value).to eq barcode

    # status indicator should be 'X'
    expect(page).not_to have_selector("i.icon-ok",     visible: true)
    expect(page).to     have_selector("i.icon-remove", visible: true)
  end
  scenario "should not indicate a duplicate barcode for the current item's barcode" do
    login_as_admin
    item = items(:macbook1)
    visit edit_item_path(item)

    fill_in :item_barcode, with: "#{item.barcode[0..1]}#{item.barcode[-4,4]}"
    expect(find("#item_barcode").value).to eq item.barcode

    # status indicator should be the checkmark
    expect(page).to     have_selector("i.icon-ok",     visible: true)
    expect(page).not_to have_selector("i.icon-remove", visible: true)
  end
end