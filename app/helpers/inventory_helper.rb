module InventoryHelper
  def active_class option, param: "by", default: false
    active_string = " class='active'".html_safe
    if !params.has_key?(param) and default
      return active_string
    end
    if params.has_key?(param) and params[param] == option
      return active_string
    end
  end

  def render_inventory_partial
    return "" unless params["by"]
    if permitted_inventory_partials.include?(params["by"].to_sym)
      render partial: "inventory/#{params['by']}"
    end
  end

  def permitted_inventory_partials
    [:location, :department]
  end
end
