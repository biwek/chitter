env = ENV["RACK_ENV"] ||= "development"


require 'sinatra'
require 'data_mapper'
require_relative '../lib/peep'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

DataMapper.finalize

DataMapper.auto_upgrade!

get '/' do 
	erb :index
end