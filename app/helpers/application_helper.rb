# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def flashes
		return "" if flash.empty?
		htm = '<div class="flashes">'
		flash.each do |type, msg|
			htm << content_tag(:div, msg, :class => type)
		end
		htm << '</div>'
		return htm
	end

  def check_box_for_collection(model, property, value, extras = {})
    input_name = model.class.name.downcase
    field_name = property.to_s.singularize + "_ids"
    check_box_tag "#{input_name}[#{field_name}][]", value, model.send(field_name).include?(value)
  end
end
