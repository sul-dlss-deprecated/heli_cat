class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.new("jdoe")
  end
  helper_method :current_user

  # This is the date that determines by the warranty
  # if an item is to be swapped.  If the warranty expires
  # BEFORE this date then the item is eligible to be swapped.
  def warranty_cutoff
    Date.parse("#{Date.today.year}-12-31")
  end
end
