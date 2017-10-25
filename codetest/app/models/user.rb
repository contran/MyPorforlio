class User < ApplicationRecord
    attr_accessor :firstname, :lastname, :email, :username, :password, :password_confirmation, :token
    has_secure_password
    has_many :posts
    has_many :comments
    
    attr_accessor :updating_password
    
    before_save { |user|
    user.email = email.to_s.downcase
    }
    before_create :create_token
    
    #validates :firstname, presence: true, length: {:maximum => 50}
    #validates :lastname, presence: true, length: {:maximum => 50}
    #validates :username, presence: true, length: {:maximum => 50}

    #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    #validates :email, presence: true,
    #format: {:with => VALID_EMAIL_REGEX},
    #uniqueness: {:case_sensitive => false}
    validates :password_digest, presence: {:message => 'Please confirm your password'}, :if => :updating_password
    
    def should_validate_password?
        updating_password
    end
    
    
    private
    
    def create_token
        self.token = SecureRandom.urlsafe_base64
    end
end
