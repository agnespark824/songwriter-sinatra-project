require './config/environment'

class ApplicationController < Sinatra::Base

	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
		enable :sessions
		set :session_secret, "dwizzy_dweek"
  	end

	helpers do
		def logged_in?
			!!session["user_id"]
		end

		def login(username, password)
			user = User.find_by(username: username)  
			if user && user.authenticate(password)
				session["user_id"] = user.id
			else
				erb :"sessions/error.html"
			end
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
    	erb :"sessions/home"
	end
    
end
