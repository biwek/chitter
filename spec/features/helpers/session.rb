module SessionHelpers

	def sign_in(email, password)
		visit '/sessions/new'
		within('#sign_in') do 
			fill_in 'email', with: email
			fill_in 'password', with: password
			click_button 'Sign in'
		end
	end

	def sign_up(email, password, confirm_password, name, username)
		visit '/users/new'
		within('#sign_up') do 
			fill_in 'email', with: email
			fill_in 'password', with: password
			fill_in 'confirm_password', with: confirm_password
			fill_in 'name', with: name
			fill_in 'username', with: username
			click_button 'Sign up'
		end
	end	

end