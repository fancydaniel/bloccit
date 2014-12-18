class CommentsController < ApplicationController

 def create
    @comment = current_user.comments.build(params.require(:comment).permit(:body))
    post = Post.find(params[:post_id])
    @comment.post = post
    topic = Topic.find(params[:topic_id])
    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [topic, post]  # Does this need to be changed? Do we add @comments?
    end
  end

end