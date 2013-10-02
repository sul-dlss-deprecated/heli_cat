require 'tracking/activity'
require 'tracking/UPS'
class Tracking
  def self.new item
    raise Tracking::UnknownProvider unless self.known_providers.include?(item.shipping_provider)
    Tracking.const_get(item.shipping_provider).new(item.tracking_number)
  end

  private
  def self.known_providers
    ["UPS"]
  end

  class UnknownProvider < StandardError
    def initialize msg = "Unknown Shipping Provider"
      super msg
    end
  end
end