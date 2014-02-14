env = ENV["RACK_ENV"] ||= "development"

require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require_relative '../lib/peep'
require_relative '../lib/user'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
DataMapper.finalize
DataMapper.auto_upgrade!

enable :sessions
set :session_secret, 'secret key'

use Rack::Flash

get '/' do 
	erb :index
end

post '/peep' do
	peep = params[:post]
	Peep.create({post: peep}) 
	redirect '/'
end

get '/users/new' do 
	erb :'users/new'
end

post '/users' do 
	user = User.new({ email: params[:email], 
								password: params[:password], 
								password_confirmation: params[:confirm_password], 
								name: params[:name],
								username: params[:username]})
	if user.save
		session[:user_id] = user.id
		redirect to('/')
	else
		flash[:error] = 'Sorry, your passwords do NOT match!'
		erb :'users/new'
	end
end

helpers do 
	def current_user
		@current_user ||=User.get(session[:user_id]) if session[:user_id]
	end
end