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
end
