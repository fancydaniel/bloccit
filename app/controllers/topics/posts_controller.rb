class Topics::PostsController < ApplicationController
  
  # Removed as nesting under Topic
  # def index
  #   @posts = Post.all
  #   authorize @posts
  # end

 
  def show
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
    authorize @topic
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new     
     authorize @post
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
    authorize @post

    if @post.save
        @post.create_vote   # Added as part of rspec
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
    # Old code before posts were nested under topics
    # @post = current_user.posts.build(params.require(:post).permit(:title, :body))
    #   authorize @post
    # if @post.save
    #   flash[:notice] = "Post was saved."
    #   redirect_to @post
    # else
    #   flash[:error] = "There was an error saving the post. Please try again."
    #   render :new
    # end
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @comments = Comment.find(params[:id]) # Added for posts
    authorize @post

    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    title = @post.title
    authorize @post

    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end

   def index
      @posts = Post.visible_to(current_user).where("posts.created_at > ?", 7.days.ago).paginate(page: params[:page], per_page: 10)
  end

   private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end


end
