require 'sinatra'
require 'sinatra/base'
require 'data_mapper'

require_relative '../lib/peep'
require_relative '../lib/user'
require_relative './data_mapper_config'
require_relative './controllers/base'
require_relative './controllers/peeps'
require_relative './controllers/users'
require_relative './controllers/authentication'

class Chitter < Sinatra::Base
	use Controllers::Peeps
	use Controllers::Users
	use Controllers::Authentication
end