class InventoryController < ApplicationController

  def index
    by = items_index_params["by"].try(:to_sym)
    value = params["value"]
    @items = []
    @options = Item.select(by).uniq
    if by and !value.blank?
      @items = Item.where(by => value)
    elsif by
      @items = Item.order(by)
    end
  end

  private

  def items_index_params
    p = params.permit(:by)
    p.delete_if do |key, val|
      !permitted_by_params.include?(val.to_sym)
    end
  end

  def permitted_by_params
    [:location, :department]
  end
end
