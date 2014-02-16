module Controllers
	class Users < Base
		get '/users/new' do 
			erb :'users/new'
		end

		post '/users' do 
			user = User.new({ email: params[:email], 
										password: params[:password], 
										password_confirmation: params[:confirm_password], 
										name: params[:name],
										username: params[:username]})
			if user.save
				session[:user_id] = user.id
				redirect to('/')
			else
				flash.now[:errors] = user.errors.full_messages
				erb :'users/new'
			end
		end
	end
end