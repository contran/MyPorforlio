class UsersController < ApplicationController
    def new
    end
    
    def create
        logger.info "users_controller new **** "
        
        user = User.new
        user.email = params[:email].to_s
        user.firstname = params[:firstname].to_s
        user.lastname = params[:lastname].to_s
        user.username = params[:username].to_s
        user.password_digest = BCrypt::Password.create(params[:password].to_s)
        if user.save!
            redirect_to posts_path(:id => user.id)
            else
            respond_to do |format|
                format.js { render :action => 'errors.js.ejb' }
            end
        end
    end
end
