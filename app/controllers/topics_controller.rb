class TopicsController < ApplicationController
    def index
        @topics = Topic.all
    end
    
    def show
        @topic = Topic.find(params[:id])
    end
    
    def new
        @topic = Topic.new
    end
    
    def create
#removed due to code smell and refactored using private method / mass-assignment and strong parameters
#        @topic = Topic.new
#        @topic.name = params[:topic][:name]
#        @topic.description = params[:topic][:description]
#        @topic.public = params[:topic][:public]
        @topic = Topic.new(topic_params) #post_params pulled from private method at bottom of page
        
        if @topic.save
            flash[:notice] = "Topic was saved succesfully."
            redirect_to @topic
        else
            flash.now[:alert] = "Error creating topic. Please try again."
            render :new
        end
    end
    
    def edit
        @topic = Topic.find(params[:id])
    end
    
    def update
        @topic = Topic.find(params[:id])
#removed due to code smell and refactored using private method / mass-assignment and strong parameters
#        @topic.name = params[:topic][:name]
#        @topic.description = params[:topic][:description]
#        @topic.public = params[:topic][:public]
        @topic.assign_attributes(topic_params) #post_params pulled from private method at bottom of page
        
        if @topic.save
            flash[:notice] = "Topic was updated successfuy."
            redirect_to @topic
        else
            flash.now[:alert] = "Error saving topic. Please try again."
            render :edit
        end
    end
    
    def destroy
        @topic = Topic.find(params[:id])
        
        if @topic.destroy
            flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
            redirect_to action: :index
        else
            flash.now[:alert] = "There was an error deleting the topic."
            render :show
        end
    end
    
    private
    
    def topic_params
        params.require(:topic).permit(:name, :description, :public)
    end
end