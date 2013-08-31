class ItemsController < ApplicationController
  layout "inventory"
  
  after_filter :send_request_email, only: :create

  before_filter :authorize_current_user_or_admin, except: [:find, :show, :to_be_swapped, :create]

  def create
    @item = Item.create(item_create_params)
    flash[:success] = "#{@item.title} was succesfully added!"
    redirect_to item_path(@item)
  end
  
  def find
    @items = Item.where(item_find_params)
    respond_to do |format|
      format.html
      format.xml  {render xml:  @items.to_xml}
      format.json {render json: @items.to_json}
    end
  end

  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html
      format.xml  {render xml:  @item.to_xml}
      format.json {render json: @item.to_json}
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_update_params)
      flash[:success] = "#{@item.title} was succesfully updated!"
    else
      flash[:error] = "There was a problem updating #{@item.title}.  Please try again."
    end
    redirect_to :back
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash[:notice] = "<strong>#{item.title}</strong> removed from the inventory."
    redirect_to inventory_location_path
  end

  def to_be_swapped
    @items = Item.where("warranty_end <= ?", warranty_cutoff)
    respond_to do |format|
      format.html
      format.xml  {render xml: @items.to_xml}
      format.json {render xml: @items.to_json}
    end
  end

  def swap
    @item = Item.find(params[:id])
    # Don't reload the user unless necessary
    if @item.user == current_user.id
      user = current_user
    else
      user = User.new(@item.user)
    end
    @swappable_items = user.equipment.select do |equipment|
      equipment.id != @item.id
    end
  end

  def choose_swap
    @item = Item.find(params[:id])
    @purchase_options = PurchaseOption.where(make: @item.make)
  end

  def change_swap_model
    item = Item.find(params[:id])
    purchase_option = PurchaseOption.find(params[:purchase_option_id])
    item.purchase_option = purchase_option
    item.save
    flash[:success] = "#{item.title} swap model updated to #{purchase_option.model}."
    redirect_to item_path(item)
  end

  def request_swap_purchase
    item = Item.find(params[:id])
    if item.purchase_option
      item.clone_for_swap!
      flash[:success] = "The purchase of a #{item.purchase_option.model} to replace #{item.title} has been initiated."
    else
      flash[:error] = "#{item.title} has not had a swap model selected yet!"
    end
    redirect_to :back
  end

  def do_swap
    if params[:swap_id]
      old_item = Item.find(params[:id])
      new_item = Item.find(params[:swap_id])
      old_item.destroy
      flash[:success] = "<strong>#{old_item.title}</strong> removed from the inventory and <strong>#{new_item.title}</strong> swapped in its place."
      redirect_to edit_item_path(new_item)
    end
  end

  def track
    item = Item.find(params[:id])
    if item.stored_tracking_information.blank? or params[:update]
      item.stored_tracking_information = item.tracking_information
      item.save
    end
    render json: item.stored_tracking_information
  end

  private

  def send_request_email
    if params[:send_email]
      PurchaseRequest.new_purchase(@item, params[:purchase_option_id]).deliver
    end
  end

  def item_find_params
    p = params.dup
    p.delete(:controller)
    p.delete(:action)
    p.delete(:format)
    p
  end

  def item_update_params
    params.require(:item).permit(permitted_item_params)
  end

  def item_create_params
    params.require(:item).permit(permitted_item_params)
  end
  def permitted_item_params
    [:user, :department, :location, :make, :model, :barcode, :serial, :express_service_code, :computer_name, :ip_address, :wireless_mac, :wired_mac, :swap_cycle_number, :swap_cycle_span, :warranty_end, :shipping_provider, :tracking_number, :tracking_url, :notes, :purchased, :received]
  end
end
