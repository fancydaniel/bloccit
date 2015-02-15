class CommentsController < ApplicationController

  respond_to :html, :js

 def create
    @comment = current_user.comments.build(params.require(:comment).permit(:body))
    post = Post.find(params[:post_id])
    @comment.post = post
    # topic = Topic.find(params[:topic_id])
    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [post.topic, post]  # Does this need to be changed? Do we add @comments?
    end
  end

  def destroy
    #@topic = Topic.find(params[:topic_id])
    # topic = Topic.post.find <-- remove this
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])
    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment was removed."
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
      # redirect_to [post.topic, post]
    end

    respond_with(@comment) do |format|
      format.html { redirect_to [post.topic, post] }
    end
  end

end