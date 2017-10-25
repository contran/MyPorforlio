class Post < ApplicationRecord
    belongs_to :user
    has_many :comments
    
    #validates :title, presence: true,
    #length: { minimum: 4, maximum: 200 }
    
    #validates :text, presence: true,
    #length: { maximum: 1000 }
    #validates :user_id, presence: true
end
