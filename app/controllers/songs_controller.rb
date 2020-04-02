class SongsController < ApplicationController

	get "/songs" do
		if !logged_in?
			redirect "/"
		else
			current_user
			erb :"/songs/index.html"
		end
  	end

	get "/songs/new" do
		erb :"/songs/new.html"
	end
  	
  	post "/songs" do
    	redirect "/songs"
  	end

  	get "/songs/:id" do
		@song = Song.find(params["id"])
		erb :"/songs/show.html"
	end

	get "/songs/:id/edit" do
		@song = Song.find(params["id"])
		erb :"/songs/edit.html"
  	end

  	patch "/songs/:id" do
		@song = Song.find(params["id"])
		@song.update(params["id"])
		redirect '"/@song.id">songs/#{@song.id}'
	end

  	delete "/songs/:id/delete" do  
		@song = Song.find(params["id"])
		@song.destroy
		redirect "/songs"
	end
end
