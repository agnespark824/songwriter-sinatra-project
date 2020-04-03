require './config/environment'

class ApplicationController < Sinatra::Base

	configure do
		enable :sessions
		register Sinatra::Flash
		set :public_folder, 'public'
		set :views, 'app/views'
		set :session_secret, "dwizzy"
		#set :method_override, true
  	end

	helpers do
		def login(username, password)
			user = User.find_by(username: username)  
			if user && user.authenticate(password)
				session["user_id"] = user.id
				redirect "/songs"
			else
				flash[:warning] = "The username and password you entered did not match our records. Please try again."
				redirect "/"
			end
		end	
		
		def logged_in?
			!!session["user_id"]
		end

		def current_user
			if logged_in?
				@current_user ||= User.find(session["user_id"])
			end
		end
		
		def logout!
			session.clear
		end
	end

	get "/" do
		if logged_in?
			redirect "/songs"
		else
			erb :"sessions/home"
		end
	end

	post "/" do
		login(params["username"], params["password"])
	end
    
end
