module PurchaseHelper

  def render_purchase_step
    if params["make"].blank? and params["model_id"].blank?
      render "make_selection"
    elsif !params["make"].blank?
      render "model_selection"
    end
  end
  
  def render_purchase_options
    return if params["make"].blank? or
              !["Mac", "PC"].include?(params["make"])
    render partial: "option", collection: PurchaseOption.where(make: params["make"], active: true)
  end

end