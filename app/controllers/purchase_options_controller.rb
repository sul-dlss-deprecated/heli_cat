class PurchaseOptionsController < ApplicationController
  layout "inventory"

  def show
    @purchase_option = PurchaseOption.find(params[:id])
  end

  def edit
    @purchase_option = PurchaseOption.find(params[:id])
  end

  def create
    @purchase_option = PurchaseOption.create(create_purchase_option_params)
    flash[:success] = "Purchase Option #{@purchase_option.model} successfully created!"
    redirect_to :back
  end

  def deactivate
    purchase_option = PurchaseOption.find(params[:id])
    if purchase_option.active
      purchase_option.active = false
      purchase_option.save
      flash[:success] = "Purchase Option #{purchase_option.model} deactivated!"
    else
      flash[:notice] = "Purchase Option #{purchase_option.model} already deactivated!"
    end
    redirect_to :back
  end

  def activate
    purchase_option = PurchaseOption.find(params[:id])
    if purchase_option.active
      flash[:notice] = "Purchase Option #{purchase_option.model} already activated!"
    else
      purchase_option.active = true
      purchase_option.save
      flash[:success] = "Purchase Option #{purchase_option.model} activated!"
    end
    redirect_to :back
  end

  private

  def create_purchase_option_params
    params.require(:purchase_option).permit(:make, :model, :description, :active)
  end
end