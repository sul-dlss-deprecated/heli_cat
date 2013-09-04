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
    [:location, :department, :make, :model]
  end

  def warranty_class(item)
    if item.days_left_in_warranty
      if item.days_left_in_warranty < 0
        "expired"
      else
        case item.days_left_in_warranty
          when 0...183 then "almost-expired"
          when 184...365 then "expires-within-year"
          when 366...730 then "expires-next-year"
          else
            "not-expiring-soon"
        end
      end
    end
  end

  def warranty_status_text
    {"expired" => "The warranty for this item has expired!",
     "almost-expired" => "This item's warranty will expire within the next 6 months.",
     "expires-within-year" => "This item's warrany will expire within the next year.",
     "expires-next-year" => "This item's warrany doesn't expire until next year.",
     "not-expiring-soon" => "This warranty will not expire anytime soon."}
  end

  def pagination_counter(counter)
    gap = 0
    unless params[:page].blank? or params[:page].to_i < 2
      gap = (params[:page].to_i - 1) * HeliCat::Application.config.per_page
    end
    counter + gap + 1
  end
end
