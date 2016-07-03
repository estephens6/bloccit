class PostsController < ApplicationController
  
  before_action :require_sign_in, except: :show
  before_action :authorize_user, except: [:show, :new, :create]
#  def index
#    @posts = Post.all    
#  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end
  
  def create
#removed due to code smell and refactored using private method / mass-assignment and strong parameters
#    @post = Post.new
#    @post.title = params[:post][:title]
#    @post.body = params[:post][:body]
#    @post.topic = @topic
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params) #post_params pulled from private method at bottom of page
    @post.user = current_user
    
    if @post.save
      flash[:notice] = "Post was saved sucessfully."

#      redirect_to @post
      redirect_to [@topic, @post]

    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
#removed due to code smell and refactored using private method / mass-assignment and strong parameters
#    @post.title = params[:post][:title]
#    @post.body = params[:post][:body]
    @post.assign_attributes(post_params) #post_params pulled from private method at bottom of page
    
    if @post.save
      flash[:notice] = "Post was updated successfully."
#      redirect_to @post
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
#      redirect_to posts_path
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end
  
  private
  
    def post_params
      params.require(:post).permit(:title, :body)
    end
    
    def authorize_user
      post = Post.find(params[:id])
      
      unless current_user == post.user || current_user.admin?
        if self.action_name == 'destroy'
          auth_failure('admin', post)
        else
          unless current_user.moderator?
            auth_failure('moderator or an admin', post)
          end
        end
      end
    end
    
    def auth_failure(role, post)
      flash[:alert] = "PostController: You must be the creator of this post or #{role == 'admin' ? 'an' : 'a'} #{role} to " \
                      "#{self.action_name == 'new' ? 'create' : self.action_name} a post. [current_user.name(role) = '#{current_user.name}{#{current_user.role})']"
      redirect_to [post.topic, post]
    end
end
    
