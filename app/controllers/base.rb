require 'rack-flash'
require_relative '../helpers/app_helper'

module Controllers
	class Base < Sinatra::Base
		enable :sessions
		set :session_secret, 'secret key'
		
		use Rack::Flash
		use Rack::MethodOverride
		
		helpers AppHelper

		set :views, File.join(File.dirname(__FILE__), '../views')
	end
end