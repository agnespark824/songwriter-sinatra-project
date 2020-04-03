class UsersController < ApplicationController

	get "/users" do
		if logged_in?
			@user = User.find(session[:user_id])
			erb :"users/show.html"
		else
			redirect "/"  
		end
	end
	
	get "/users/:id" do
		if logged_in?
			@user = User.find(params["id"])

			erb :"users/show.html"
		else
			redirect "/"
		end
	end
		
	get "/signup" do
		if logged_in?
			redirect "/songs"
		else
			erb :"users/new.html"
		end
	end

	post "/signup" do
		if params["user"]["first_name"].empty? || params["user"]["last_name"].empty? || params["user"]["username"].empty? || params["user"]["password"].empty?
			flash[:warning] = "Please fill out all forms."
			redirect "/signup"
		else
			flash[:notice] = "Your account has been successfully created. Please log in."
			@user = User.create(first_name: params["user"]["first_name"], last_name: params["user"]["last_name"], username: params["user"]["username"], password: params["user"]["password"])

			redirect "/"
		end
	end
	  
    get "/logout" do
		if logged_in?
			logout!
		end
		redirect "/"
    end

 	post "/users" do
    	@user = User.new(first_name: params["user"]["first_name"], last_name: params["user"]["last_name"],username: params["user"]["username"], password: params["user"]["password"])
		if @user.save
			flash[:notice] = "Success!"
      		session["user_id"] = @user.id
      		redirect "/"
    	else
			flash[:notice] = "Please try again."
			redirect "/signup"
    	end
	end
	  
	get "/users/:id/edit" do
		@user = User.find(session["user_id"])
		if @user && @user == current_user
			erb :"/users/edit.html"
		else
			redirect "/"
		end
	end

	patch "/users/:id" do
		if logged_in?
			@user = User.find(params["user"])
			@user.update(params["user"])
			redirect "/@user.id"
		else
			redirect "/"
		end
	end
end

