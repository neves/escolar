require "digest"

class RestartController < ApplicationController
	skip_before_filter :login_required, :current_escola
	before_filter :authenticate

	def index
		`touch tmp/restart.txt`
		render :text => "restarted!"
	end

	private
	def authenticate
		authenticate_or_request_with_http_basic('Restart Rails') do |username, password|
			username == 'neves' && (Digest::MD5.hexdigest(password) == '94feb4f9d4014798a8123788b45ea149')
		end
	end
end