class Tracking
  class UPS
    def initialize tracking_number
      @tracking_number = tracking_number
    end
    def activity
      response.xpath("//TrackResponse/Shipment/Package/Activity").map do |activity|
        locations = [activity.xpath("./ActivityLocation/Address/City").text.strip, activity.xpath("./ActivityLocation/Address/StateProvinceCode").text.strip]
        Tracking::Activity.new do
          location    locations.select{|location| !location.blank? }.compact.join(", ")
          description activity.xpath("./Status/StatusType/Description").text
          date        activity.xpath("./Date").text
          time        activity.xpath("./Time").text
        end
      end
    end
    private
    def response
      @response ||= Nokogiri::XML( RestClient.post(api_url, request_xml, content_type: "application/x-www-form-urlencoded") )
    end
    def api_url
      "https://wwwcie.ups.com/ups.app/xml/Track"
    end
    def access_license_number
      config["access_license_number"]
    end
    def user_id
      config["user_id"]
    end
    def password
      config["password"]
    end
    def request_xml
      <<-XML
      <?xml version="1.0"?>
      <AccessRequest xml:lang="en-US">
        <AccessLicenseNumber>#{access_license_number}</AccessLicenseNumber>
        <UserId>#{user_id}</UserId>
        <Password>#{password}</Password>
      </AccessRequest>
      <?xml version="1.0"?>
      <TrackRequest xml:lang="en-US">
        <Request>
          <TransactionReference>
            <CustomerContext>Your Test Case Summary</CustomerContext>
            <XpciVersion>1.0</XpciVersion>
          </TransactionReference>
          <RequestAction>Track</RequestAction>
          <RequestOption>activity</RequestOption>
        </Request>
        <TrackingNumber>#{@tracking_number}</TrackingNumber>
      </TrackRequest>
      XML
    end
    def config
      YAML.load_file("#{Rails.root}/config/UPS.yml")[Rails.env]
    end
  end
end