class FavoriteMailer < ApplicationMailer
    default from: "perkinsdrive@gmail.com"
    
    def new_comment(user, post, comment)
        
        #headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
        #headers["In-Replay-To"] = "<post/#{post.id}@your-app-name.example>"
        #headers["References"] = "<post/#{post.id}@your-app-name.example>"
        
        headers["Message-ID"] = "<comments/#{comment.id}@bloccit.io>"
        headers["In-Reply-To"] = "<post/#{post.id}@bloccit.io>"
        headers["References"] = "<post/#{post.id}@bloccit.io>"
        
        @user = user
        @post = post
        @comment = comment
        
        mail(to: user.email, subject: "New comment on #{post.title}")
    end
end
