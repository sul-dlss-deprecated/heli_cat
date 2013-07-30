class PurchaseRequest < ActionMailer::Base
  default from: "no-reply@heli-cat.stanford.edu"

  def new_purchase(item, purchase_option_id=nil)
    @host = host
    @item = item
    @purchase_option = if purchase_option_id
      PurchaseOption.find(purchase_option_id)
    else
      nil
    end
    mail(to: HeliCat::Application.config.dlss_admin_email, subject: "New computer purchase request.")
  end

  private

  def host
    if Rails.env.production?
      "heli-cat.stanford.edu"
    else
      "localhost:3000"
    end
  end
end
