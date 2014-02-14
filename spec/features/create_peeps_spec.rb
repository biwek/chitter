require 'spec_helper'

feature "Creating peeps" do 

	scenario "when in the homepage" do
		visit '/'
		expect(Peep.count).to eq(0)
		create_peep("John", "jodoe", "My first post")
		expect(Peep.count).to eq(1)
		peep = Peep.first({username: 'jodoe'})
		expect(peep.post).to eq("My first post")
	end

	def create_peep(name, username, post)
		within('#create_peep') do 
			fill_in 'post', with: post
			click_button 'Peep'
		end
	end

end