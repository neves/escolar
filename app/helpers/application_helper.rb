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
end
