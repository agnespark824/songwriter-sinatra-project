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
			@user = User.create(params["user"])
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
    	@user = User.new(params["user"])
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
		@user = User.find(session["user_id"])
		if @user && @user == current_user
			@user.update(params["user"])
			flash[:notice] = "Success!"
			redirect "/users/#{@user.id}"
		else
			redirect "/"
		end
	end

	get "/users/:id/delete" do  
		if logged_in?
			@user = User.find(session["user_id"])
			erb :"/users/delete.html"
		else
			flash[:notice] = "You must be logged in to perform this action."
			redirect "/"
		end
	end
	
	delete "/users/:id" do  
		@user = User.find(session["user_id"])
		if @user.authenticate(params["user_password"])
			@user.destroy
			flash[:notice] = "Your account has been deleted."
			redirect "/logout"
		else
			flash[:notice] = "That is not the correct password."
			redirect "/users/:id"
		end
	end
end

