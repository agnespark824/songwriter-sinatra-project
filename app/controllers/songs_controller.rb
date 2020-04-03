class SongsController < ApplicationController

	get "/songs" do
		if !logged_in?
			redirect "/"
		else
			@songs = Song.where(user_id: current_user)
			erb :"/songs/index.html"
		end
  	end

	get "/songs/new" do
		erb :"/songs/new.html"
	end
  	
	post "/songs" do
		@song = Song.create(title: params["song"]["title"], themes: params["song"]["themes"], notes: params["song"]["notes"], lyrics: params["song"]["lyrics"])
		@song.user = current_user
		@song.save
    	redirect "/songs"
  	end

	get "/songs/:id/edit" do
		@user = User.find(session["user_id"])
		@song = Song.find(params["id"])
		if @song && @song.user == current_user
			erb :"/songs/edit.html"
		else
			redirect "/"
		end
  	end

  	patch "/songs/:id" do
		if logged_in?
			@song = Song.find(params["id"])
			@song.update(title: params["song"]["title"], themes: params["song"]["themes"], notes: params["song"]["notes"], lyrics: params["song"]["lyrics"])
			@song.save
			redirect "/songs/#{@song.id}"
		else
			redirect "/"
		end
	end

  	delete "/songs/:id/delete" do  
		@song = Song.find(params["id"])
		@song.destroy
		redirect "/songs"
	end

	get "/songs/:id" do
		@song = Song.find(params["id"])
		erb :"/songs/show.html"
	end
end
