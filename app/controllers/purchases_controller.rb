class PurchasesController < ApplicationController
  def new
    @pending_purchases = Item.where(user: current_user.id, received: false)
  end
end
