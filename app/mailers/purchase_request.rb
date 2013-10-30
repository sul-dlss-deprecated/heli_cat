class PurchaseRequest < ActionMailer::Base
  default from: "no-reply@helicat.stanford.edu"

  def new_purchase(item, current_user, purchase_option_id=nil)
    @host = host
    @item = item
    @current_user = current_user
    @purchase_option = if purchase_option_id
      PurchaseOption.find(purchase_option_id)
    else
      nil
    end
    mail(to: HeliCat::Application.config.dlss_ep_email, subject: "New equipment purchase request.")
  end

  private

  def host
    if Rails.env.production?
      "helicat.stanford.edu"
    else
      "localhost:3000"
    end
  end
end
