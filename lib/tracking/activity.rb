class Tracking
  class Activity
    def initialize(attributes = {}, &block)
      if block_given?
        instance_eval(&block)
      else
        attributes.each do |method,value|
          self.send method.to_sym, value
        end
      end
    end

    def location location=""
      @location ||= location
    end
    def description description=""
      @description ||= description
    end
    def date date=""
      @date ||= Date.parse date
    end
    def time time=""
      @time ||= DateTime.strptime(time, '%H%M').strftime('%l:%M%P').strip
    end
    def to_s
      "#{date} (#{time}): #{description}#{' @ ' + location unless location.blank?}"
    end
  end
end