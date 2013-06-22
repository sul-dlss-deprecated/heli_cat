module HomeHelper
  def home_span_class
    current_user ? "span4" : "span6"
  end
end