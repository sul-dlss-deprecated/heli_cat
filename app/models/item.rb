class Item < ActiveRecord::Base
  has_one :purchase_option
  def swap_cycle_number=(number)
    self.swap_cycle = "#{number}-#{swap_cycle_span}"
    self.save!
  end
  def swap_cycle_span=(span)
    self.swap_cycle = "#{swap_cycle_number}-#{span}"
    self.save!
  end
  def swap_cycle_number
    return nil unless swap_cycle
    swap_cycle.split("-").first
  end
  def swap_cycle_span
    return nil unless swap_cycle
    swap_cycle.split("-").last
  end
  def destroy
    swappable_items = self.class.where(swap_item: self.id)
    unless swappable_items.blank?
      swappable_items.each do |item|
        item.swap_item = nil
        item.save
      end
    end
    super
  end
end
