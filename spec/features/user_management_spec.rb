require_relative './helpers/session'
include SessionHelpers

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

	scenario "with invalid details" do 
		visit '/'
		sign_in("juan@example.com", "wrongpass")
		expect(page).not_to have_content("Welcome, Juan Mata")
		expect(page).to have_content("Sorry, wrong email or password!")
	end

end

feature "User signs out" do 

	before(:each) do 
		User.create({name: 'Juan Mata',
								 username: 'juan8',
								 email: 'juan@example.com',
								 password: 'pass',
								 password_confirmation: 'pass'})
	end

	scenario "after signing in" do 
		visit '/'
		sign_in("juan@example.com", "pass")
		expect(page).to have_content("Welcome, Juan Mata")
		click_button 'Sign out'
		expect(page).not_to have_content('Welcome, Juan Mata')
		expect(page).to have_content("You have successfully been signed out!")
	end

end