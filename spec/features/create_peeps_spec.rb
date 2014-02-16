require 'spec_helper'
require_relative './helpers/peep'
require_relative './helpers/session'
include PeepHelpers
include SessionHelpers

feature "Creating peeps" do 

	before(:each) do 
		User.create({name: 'John',
								 username: 'jodoe',
								 email: 'john@example.com',
								 password: 'johnpass',
								 password_confirmation: 'johnpass'})
	end

	scenario "when signed in" do
		visit '/'
		sign_in('john@example.com', 'johnpass')
		expect(Peep.count).to eq(0)
		create_peep("My first post")
		expect(Peep.count).to eq(1)
		peep = Peep.first
		expect(peep.post).to eq("My first post")
	end

	scenario "when not signed in" do
		visit '/'
		expect(Peep.count).to eq(0)
		lambda { create_peep("My first post") }.should raise_error('Unable to find css "#create_peep"')
		expect(Peep.count).to eq(0)
	end

end