module HomeHelper
  def home_span_class
    current_user && current_user.equipment.length > 0 ? "span4" : "span6"
  end
end