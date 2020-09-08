class SessionsController < ApplicationController
    
    def destroy
        session.clear
        redirect_to root_path
    end

    def home
        if !logged_in?
            root_path
        else
            redirect_to lists_path
        end
    end

    def create
        user = User.find_by(username: params[:user][:username])
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            redirect_to user_path(user)
        else
            flash[:message] = "Incorrect login information"
            redirect_to "/login"
        end
    end

    def google
        #finding or creating a user using attributes
        @user = User.find_or_create_by(email: auth["info"]["email"]) do |u|
            u.username= auth["info"]["first_name"]
            u.password= SecureRandom.hex(10)
        end
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            redirect_to '/'
        end

    end

    def auth
        request.env['omniauth.auth']
    end

end