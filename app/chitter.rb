
require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require_relative './helpers/app_helper'
require_relative '../lib/peep'
require_relative '../lib/user'
require_relative './data_mapper_config'

enable :sessions
set :session_secret, 'secret key'

use Rack::Flash

# peep
get '/' do 
	@peeps = Peep.all
	erb :index
end

post '/peep' do
	peep = params[:post]
	time = Time.new
	user = User.get(session[:user_id])
	Peep.create({user: user,
							 post: peep,
							 created_at: time}) 
	redirect '/'
end


# signup
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
		flash[:errors] = user.errors.full_messages
		erb :'users/new'
	end
end


# signin 
get '/sessions/new' do 
	erb :'/sessions/new'
end

post '/sessions' do
	email = params[:email]
	password = params[:password]
	user = User.authenticate(email, password)

	if user 
		session[:user_id] = user.id 
		redirect to('/')
	else
		flash.now[:error] = 'Sorry, wrong email or password!'
		erb :'/sessions/new'
	end
end

delete '/sessions' do
	flash[:notice] = "You have successfully been signed out!" 
	session[:user_id] = nil
	redirect to('/')
end

