module InventoryHelper
  def active_class option
    " class='active'".html_safe if option_active? option
  end
  
  def option_active? option
    params["by"] == option
  end
end
