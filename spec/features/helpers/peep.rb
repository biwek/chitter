module PeepHelpers 

	def create_peep(post)
		within('#create_peep') do 
			fill_in 'post', with: post
			click_button 'Peep'
		end
	end

end