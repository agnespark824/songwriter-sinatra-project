class SessionsController < ApplicationController

    get "/login/error" do
        erb :"sessions/error.html"
    end
    
    post "/sessions" do
        login(params["username"], params["password"])
        redirect "/songs"
    end
    
    get "/logout" do
        logout!
        redirect "/"
    end

end