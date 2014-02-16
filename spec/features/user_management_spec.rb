feature "User signs up" do 
	scenario "for first time" do 
		visit '/'
		sign_up("juan@example.com", "pass", "pass", "Juan Mata", "juan8")
		expect(User.count).to eq(1)
		expect(page).to have_content('Welcome, Juan Mata')
	end

	scenario "with wrong password confirmation" do 
		visit '/'
		lambda { sign_up("juan@example.com", "pass", "wrongpass", "Juan Mata", "juan8") }.should change(User, :count).by(0)
		expect(page).to have_content('Sorry, your passwords do NOT match!')
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

feature "User signs in" do 

	before(:each) do 
		User.create({name: 'Juan Mata',
								 username: 'juan8',
								 email: 'juan@example.com',
								 password: 'pass',
								 password_confirmation: 'pass'})
	end

	scenario "with valid details" do 
		visit '/'
		sign_in("juan@example.com", "pass")
		expect(page).to have_content("Welcome, Juan Mata")
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