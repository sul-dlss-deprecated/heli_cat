class Item < ActiveRecord::Base

  paginates_per HeliCat::Application.config.per_page
  max_paginates_per HeliCat::Application.config.per_page

  has_one :purchase_option
  validates :swap_cycle, format: {with: /|\d{1}-years|months|/, message: "Swap cycle not valid"}

  validates :swap_cycle_number, inclusion: { in: [nil, ""].concat(("1"..."7").to_a),
                                             message: "%{value} is not a valid number" }
  validates :swap_cycle_span,   inclusion: { in: [nil, "years", "months"],
                                             message: "%{value} is not a valid date unit" }

  serialize :stored_tracking_information, Array
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

  def days_left_in_warranty
    return nil if warranty_end.blank?
    @days_left_in_warranty ||= (warranty_end - Date.today).to_i
  end

  def clone_for_swap!
    if purchase_option
      new_swap_item = self.class.create(user:       user,
                                        department: department,
                                        location:   location,
                                        model:      purchase_option.model,
                                        make:       purchase_option.make,
                                        purchased:  true,
                                        received:   true)
      new_swap_item.save
      self.swap_item = new_swap_item.id
      self.save
    end
  end

  def is_trackable?
    !received? and !shipping_provider.blank? and !tracking_number.blank?
  end

  def tracking_information
    @tracking_information ||= Tracking.new(self).activity.map do |activity|
      activity.to_s
    end
  end

  def title
    if !user.blank? && !model.blank?
      "#{user}'s #{model}"
    elsif !user.blank? && !make.blank?
      "#{user}'s #{make}"
    elsif !model.blank? && !department.blank?
      "#{department}'s #{model}"
    elsif !model.blank? && !location.blank?
      "#{model} in #{location}"
    elsif !make.blank? && !location.blank?
      "#{make} in #{location}"
    elsif !model.blank?
      model
    elsif !make.blank?
      make
    else
      "Inventory item #{id}"
    end
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

  def self.category_options
    {""                => "Please Select...",
     "staff_computer"  => "Staff Computer",
     "staff_monitor"   => "Staff Monitor",
     "loaner_computer" => "Loaner Computer",
     "lab_computer"    => "Lab Computer",
     "lab_monitor"     => "Lab Monitor",
     "lab_equipment"   => "General Lab Equipment"
    }
  end

  def self.categories
    category_options.to_a.map{ |a| a.reverse }
  end
end
