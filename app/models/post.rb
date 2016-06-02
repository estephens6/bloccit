class Post < ActiveRecord::Base
    has_many :comments

    def spam
        p "SPAM" if @Posts.title > 4
    end
end

