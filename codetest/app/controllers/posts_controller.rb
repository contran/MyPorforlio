class PostsController < ApplicationController
    before_action :require_login
    def show
        require 'open-uri'
        @post_list = Post.order('user_id')
    end
    
    def create
        @current_user = User.find_by_token(cookies[:remembered_token])
        if @current_user
            post = Post.new
            post.title = params[:title].to_s
            post.text = params[:text].to_s
            post.user_id = @current_user.id
            post.save!
        end
        render 'show'
    end
    
    private
    def require_login
        @current_user = User.find_by_token(cookies[:remembered_token])
        if @current_user
            return @current_user
        else
            redirect_to "/"
        end
    end
end
