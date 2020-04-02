class UsersController < ApplicationController

  	get "/signup" do
    	erb :"users/new.html"
	end
	  
	get "/success" do
		erb :"users/success.html"
	end

	get "/signup/error" do
		erb :"users/error.html"
	end

 	post "/users" do
    	@user = User.new(name: params["name"], username: params["username"], password: params["password"])
    	if @user.save
      		session["user_id"] = @user.id
      		redirect "/success"
    	else
      		erb :"users/error.html"
    	end
  	end

end

