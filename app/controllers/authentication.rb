module Controllers
	class Authentication < Base
		get '/sessions/new' do 
			erb :'/sessions/new'
		end

		post '/sessions' do
			email = params[:email]
			password = params[:password]
			user = User.authenticate(email, password)

			if user 
				session[:user_id] = user.id 
				redirect to('/')
			else
				flash.now[:error] = 'Sorry, wrong email or password!'
				erb :'/sessions/new'
			end
		end

		delete '/sessions' do
			flash[:notice] = "You have successfully been signed out!" 
			session[:user_id] = nil
			redirect to('/')
		end
	end
end