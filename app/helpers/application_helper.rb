# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def flashes
		content_tag :div, :class => "flashes" do
      ret = ""
  		flash.each do |type, msg|
  			ret << content_tag(:div, msg, :class => type)
  		end
      ret
    end unless flash.empty?
	end

  def check_box_for_collection(model, property, value, extras = {})
    input_name = model.class.name.downcase
    field_name = property.to_s.singularize + "_ids"
    check_box_tag "#{input_name}[#{field_name}][]", value, model.send(field_name).include?(value)
  end

  def empresas_select
    select_tag('escola_id', options_from_collection_for_select(@escolas, 'id', 'nome', controller.current_escola_id), {})
  end

  def date_select_futuro(f, field, options = {})
  	default = {:order => [:day, :month, :year], :include_blank => true, :start_year => Date.current.year - 2, :end_year => Date.current.year + 1}
  	f.date_select field, default
  end

	def select_options_tag(name='',select_options={},options={})
	  #set selected from value
	  selected = ''
	  unless options[:value].blank?
	    selected = options[:value]
	    options.delete(:value)
	  end
	  select_tag(name,options_for_select(select_options,selected),options)
	end

end
