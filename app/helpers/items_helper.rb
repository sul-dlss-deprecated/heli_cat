module ItemsHelper
  def render_item_form_fields context
    output = ""
    new_item_form_fields.each do |field|
      output << '<div class="control-group">'
        output << context.label(field.attribute, "#{field.text}:", class: "control-label")
        output << '<div class="controls">'
          output << context.send(field.field_type, field.attribute, placeholder: field.placeholder)
        output << "</div>"
      output << "</div>"
    end
    output.html_safe
  end
  
  def new_item_form_fields
    [OpenStruct.new(attribute: :user,           text: "User",                field_type: :text_field, placeholder: "SUNet ID"),
     OpenStruct.new(attribute: :department,     text: "Department",          field_type: :text_field, placeholder: "Webteam, DPG"),
     OpenStruct.new(attribute: :location,       text: "Location",            field_type: :text_field, placeholder: "Meyer 210, Green 315"),
     OpenStruct.new(attribute: :make,           text: "Make",                field_type: :text_field, placeholder: "Mac, Dell"),
     OpenStruct.new(attribute: :model,          text: "Model",               field_type: :text_field, placeholder: "MacBookPro, Latitude"),
     OpenStruct.new(attribute: :barcode,        text: "SU Barcode",          field_type: :text_field, placeholder: "75000000001234"),
     OpenStruct.new(attribute: :serial,         text: "Serial Number",       field_type: :text_field),
     OpenStruct.new(attribute: :computer_name,  text: "Computer Name",       field_type: :text_field, placeholder: "sul-dlss-sunet-mpb"),
     OpenStruct.new(attribute: :ip_address,     text: "IP Address",          field_type: :text_field),
     OpenStruct.new(attribute: :wireless_mac,   text: "Wirelss MAC Address", field_type: :text_field),
     OpenStruct.new(attribute: :wired_mac,      text: "Wired MAC Address",   field_type: :text_field),
     OpenStruct.new(attribute: :swap_cycle,     text: "Swap Cycle",          field_type: :text_field, placeholder: "1-year, 3-years"),
     OpenStruct.new(attribute: :warranty_start, text: "Warranty Start Date", field_type: :text_field, placeholder: "YYYY-MM-DD"),
     OpenStruct.new(attribute: :notes,          text: "Notes",               field_type: :text_area)]
  end

end