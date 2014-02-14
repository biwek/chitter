require 'spec_helper'

describe Peep do

	context "checking datamapper works" do 

		it "should be created and then retrieved from database" do
			Peep.create({name: "Biwek",
									 username: "bwake",
									 post: "hello chitter!"})
			expect(Peep.count).to eq(1)
			peep = Peep.first(username: "bwake")
			expect(peep.name).to eq("Biwek")
			expect(peep.post).to eq("hello chitter!")
			peep.destroy
			expect(Peep.count).to eq(0)
		end
	end

end