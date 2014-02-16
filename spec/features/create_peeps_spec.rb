require 'spec_helper'

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

	def create_peep(post)
		within('#create_peep') do 
			fill_in 'post', with: post
			click_button 'Peep'
		end
	end

	def sign_in(email, password)
		visit '/sessions/new'
		within('#sign_in') do 
			fill_in 'email', with: email
			fill_in 'password', with: password
			click_button 'Sign in'
		end
	end

end