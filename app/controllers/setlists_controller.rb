class SetlistsController < ApplicationController

    get "/setlists" do
        if !logged_in?
            redirect "/"
        else
            @setlists = Setlist.where(user_id: current_user)
            erb :"/setlists/index.html"
        end
    end

    get "/setlists/new" do
        @songs = Song.where(user_id: current_user)
        erb :'/setlists/new.html'
    end

    post '/setlists' do
        @setlist = Setlist.create(params["setlist"])
        @setlist.user = current_user
        @setlist.save
        redirect "/setlists/#{@setlist.id}"
    end

    get "/setlists/:id/edit" do
		@user = User.find(session["user_id"])
        @setlist = Setlist.find(params["id"])
        @songs = Song.where(user_id: current_user)
		if @setlist && @setlist.user == current_user
			erb :"/setlists/edit.html"
		else
			redirect "/"
		end
  	end
    
    
    patch "/setlists/:id" do
        if logged_in? 
            if !params["setlist"].keys.include?("song_ids")
                params["setlist"]["song_ids"] = []
            end
            @setlist = Setlist.find(params["id"])
            @setlist.update(params["setlist"])
            redirect "/setlists/#{@setlist.id}"
        else
            redirect "/"
        end
    end

    get "/setlists/:id/delete" do  
		@setlist = Setlist.find(params["id"])
		erb :"/setlists/delete.html"
	end
	
	delete "/setlists/:id" do  
		@setlist = Setlist.find(params["id"])
		@setlist.destroy
		redirect "/songs"
	end

	get "/setlists/:id" do
		@setlist = Setlist.find(params["id"])
		erb :"/setlists/show.html"
	end

end