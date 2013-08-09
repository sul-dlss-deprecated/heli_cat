class Item < ActiveRecord::Base
  has_one :purchase_option
  validates :swap_cycle, format: {with: /|\d{1}-years|months|/, message: "Swap cycle not valid"}

  validates :swap_cycle_number, inclusion: { in: [nil, ""].concat(("1"..."7").to_a),
                                             message: "%{value} is not a valid number" }
  validates :swap_cycle_span,   inclusion: { in: [nil, "years", "months"],
                                             message: "%{value} is not a valid date unit" }
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
    swap_cycle.split("-")[0]
  end
  def swap_cycle_span
    return nil unless swap_cycle
    swap_cycle.split("-")[1]
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
