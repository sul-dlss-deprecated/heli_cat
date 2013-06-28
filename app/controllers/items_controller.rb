class ItemsController < ApplicationController
  layout "inventory"
  
  def create
    @item = Item.create(item_create_params)
    flash[:notce] = "#{@item.user}'s #{@item.model} was succesfully added!"
    redirect_to :back
  end
  
  def find
    @items = Item.where(item_find_params)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def swap
    @item = Item.find(params[:id])
  end

  private

  def item_find_params
    p = params.dup
    p.delete(:controller)
    p.delete(:action)
    p
  end

  def item_create_params
    params.require(:item).permit(:user, :department, :location, :make, :model, :barcode, :serial, :computer_name, :ip_address, :wireless_mac, :wired_mac, :swap_cycle, :warranty_start, :notes)
  end
end
