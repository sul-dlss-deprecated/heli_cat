module ApplicationHelper

  def render_item_options
    if defined? @item or defined? @items
      if defined? @item
        render "items/item_options"
      elsif @items.length == 1
        render partial: "items/item_options", locals: { item: @items.first }
      end
    end
  end
end
