module Controllers
	class Peeps < Base
		get '/' do 
			@peeps = Peep.all
			erb :index
		end

		post '/peep' do
			peep = params[:post]
			time = Time.new
			user = User.get(session[:user_id])
			Peep.create({user: user,
									 post: peep,
									 created_at: time}) 
			redirect '/'
		end
	end
end