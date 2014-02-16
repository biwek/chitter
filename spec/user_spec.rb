require 'spec_helper'

describe User do

	context "checking datamapper works" do 

		it "should be created and then retrieved from database" do
			User.create({name: 'Biwek',
									 username: 'bwake',
									 email: 'biwek@shrestha.com',
									 password: 'pass',
									 password_confirmation: 'pass'})
			expect(User.count).to eq(1)
			user = User.first(username: 'bwake')
			expect(user.name).to eq("Biwek")
			expect(user.email).to eq("biwek@shrestha.com")
			user.destroy
			expect(User.count).to eq(0)
		end
	end

end