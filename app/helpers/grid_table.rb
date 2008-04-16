class GridTable
	def initialize(tpl, eixo_x, eixo_y)
		@tpl = tpl
		@eixo_x = eixo_x
		@eixo_y = eixo_y
	end

	def render(&block)
		@block = block

		p "\n<table>\n"

		rows = "\t<tr>\n\t\t<td></td>\n"
		@eixo_x.each do |x|
			rows << "\t\t<th>#{h x}</th>\n"
		end
		rows << "\t\t<td></td></tr>\n"
		p content_tag :thead, rows
		p content_tag :tfoot, rows

		p "<tbody>"

		@eixo_y.each do |y|
			p "<tr><th>#{h y}</th>"
			@eixo_x.each do |x|
				p "<td>"
				yield x, y
				p "</td>"
			end
			p "<th>#{h y}</th></tr>"
		end

		p "</tbody></table>"
	end

	private

	def p(str)
		concat(str, @block.binding)
	end

	def method_missing(*args, &block)
		@tpl.send(*args, &block)
	end
end
