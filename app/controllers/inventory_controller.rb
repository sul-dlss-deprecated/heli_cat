class InventoryController < ApplicationController

  def index
    by = items_index_params["by"].try(:to_sym)
    value = params["value"]
    @options = Item.select(by).uniq
    @items = Item.where(item_find_params).order(by)
    @items = @items.page(params[:page]) unless ["json", "xml"].include?(params[:format])
    respond_to do |format|
      format.html
      format.xml  {render xml:  @items.to_xml}
      format.json {render json: @items.to_json}
    end
  end

  private

  def items_index_params
    p = params.permit(:by)
    p.delete_if do |key, val|
      !permitted_by_params.include?(val.to_sym)
    end
  end

  def item_find_params
    by = items_index_params["by"].try(:to_sym)
    p = {}
    p[by] = params["value"] unless params["value"].blank?
    p[:category] = process_category(params["category"]) unless params["category"].blank?
    p
  end

  def process_category category = ''
    if category =~ /^all_(.*)$/
      token = $1
      Item.category_options.keys.select do |key|
        key =~ /^#{token}_/
      end
    else
      category
    end
  end

  def permitted_by_params
    [:location, :department, :make, :model]
  end
end
