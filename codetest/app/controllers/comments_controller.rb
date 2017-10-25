class CommentsController < ApplicationController
    before_filter :require_login
    def show
        require 'open-uri'
        post = Post.find(params[:id])
        comment_list = Comment.where("post_id = ?", post.id)
    end
                                                             
    def new
        user = @current_user
        post = Post.find(params[:id])
        comment = Comment.new
        comment.text = params[:text].to_s
        comment.post_id = post.id
        comment.user_id = user.id
        if comment.save!
            redirect_to comments_path
        else
            respond_to do |format|
                format.js { render :action => 'errors.js.ejb' }
            end
        end
    end
                                                             
    private
    def require_login
        unless signed_in?
        redirect_to "/"
    end
end
