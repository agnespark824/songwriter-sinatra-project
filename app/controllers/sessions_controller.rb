class SessionsController < ApplicationController

    post "/sessions" do
        login(params["username"], params["password"])
        redirect "/songs"
    end
    
    get "/logout" do
        logout!
        redirect "/"
    end

end