module SessionsHelper
    module SessionsHelper
        def sign_in(user)
            # If the user doesn't have a remember_token, add it back in.
            if user.token.nil?
                user.token = SecureRandom.urlsafe_base64
                user.save
            end
            cookies.permanent[:token] = user.token
            current_user = user
        end
        
        def signed_in?
            !@current_user.nil?
        end
        
        def current_user=(user)
            @current_user = user
        end
        
        def current_user
            if @current_user
                return @current_user
            elsif !cookies[:token].nil?
                @current_user = User.find_by_token(cookies[:token])
                return @current_user
            end
            return nil
        end
        
        def sign_out
            @current_user = nil
            cookies.delete(:token)
        end
    end

end
