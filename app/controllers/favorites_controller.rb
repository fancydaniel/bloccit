class FavoritesController < ApplicationController

  
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)
    authorize favorite

    if favorite.save
      flash[:notice] = "Favorite added"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error saving the favorite. Please try again"
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find(params[:id])
    authorize favorite

    if favorite.destroy
      flash[:notice] = "Favorite was successfully removed."
      redirect_to [@post.topic, @post]

    else
      flash[:notice] = "There was an error. Please try again."
      redirect_to [@post.topic, @post]
    end

  end



  # def destroy
  #   @topic = Topic.find(params[:topic_id])
  #   @post = Post.find(params[:id])
  #   title = @post.title
  #   authorize @post

  #   if @post.destroy
  #     flash[:notice] = "\"#{title}\" was deleted successfully."
  #     redirect_to @topic
  #   else
  #     flash[:error] = "There was an error deleting the post."
  #     render :show
  #   end
  # end

end
