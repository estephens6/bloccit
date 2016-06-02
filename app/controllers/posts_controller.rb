class PostsController < ApplicationController
  def index
    @posts = Post.all  
    @posts.each.with_index do |post, index|
#   @posts.each_with_index do |post, index| #alt code that does the same thing
      if index % 5 == 0
        post.title = "SPAM"
      end
    end
  end

  def show
  end

  def new
  end

  def edit
    
  end
end
