class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.new('jkeck')
    #User.new(request.env["WEBAUTH_USER"])
  end
  helper_method :current_user

  def current_user_is_owner_or_admin?(item = @item)
    current_user.admin? or item.user == current_user.id
  end
  helper_method :current_user_is_owner_or_admin?

  # This is the date that determines by the warranty
  # if an item is to be swapped.  If the warranty expires
  # BEFORE this date then the item is eligible to be swapped.
  def warranty_cutoff
    Date.parse("#{Date.today.year}-12-31")
  end

  private

  def authorize_admin
    unless current_user.admin?
      raise User::NotAuthorized
    end
  end

  def authorize_current_user_or_admin
    unless current_user.admin?
      if params['id']
        item = Item.find(params['id'])
        unless item.user && (item.user == current_user.id)
          raise User::NotAuthorized
        end
      end
    end
  end
end
