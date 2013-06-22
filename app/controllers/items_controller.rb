class ItemsController < ApplicationController
  layout "inventory"
  
  def create
    @item = Item.create(item_create_params)
  end
  
  private
  
  def item_create_params
    params.require(:item).permit(:user, :department, :location, :make, :model, :barcode, :serial, :computer_name, :ip_address, :wireless_mac, :wired_mac, :swap_cycle, :warranty_start, :notes)
  end
end
