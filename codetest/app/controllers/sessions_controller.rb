class SessionsController < ApplicationController
    def start
        logger.info "session#start"
        @current_user = User.find_by_token(cookies[:remembered_token])
        if @current_user
            redirect_to posts_path
        else
            render 'new'
        end
        
    end
    
    def new
        
        logger.info "sessions#new"
        
    end
    
    def create
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            @current_user = user
            cookies[:token] = user.token
            redirect_to posts_path
        else
            render 'new'
        end
    end
    
    def destroy
        @current_user = nil
        cookies.delete[:token]
        redirect_to root_path
    end
end
