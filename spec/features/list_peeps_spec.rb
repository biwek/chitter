
feature "Listing peeps" do 

	before(:each) do 
		User.create({name: 'Biwek Shrestha',
								username: 'bwake',
								email: 'biwek@shrestha.com',
								password: 'pass',
								password_confirmation: 'pass'})
	end

	scenario "after creating a peep" do 
		visit '/'
		sign_in('biwek@shrestha.com', 'pass')
		create_peep('Create and list this peep!')
		expect(page).to have_content('Create and list this peep!')
		expect(page).to have_content('Biwek Shrestha')
		expect(page).to have_content('@bwake')
	end

end