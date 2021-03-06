class TopicsController < ApplicationController
  def index
    @topics = Topic.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    authorize @topics
  end

  # private

  # def topic_params
  #   params.require(:topic).permit(:name, :description, :public))
  # end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def show
    @topic = Topic.find(params[:id])
    # @posts = @topic.posts <-- old method which doesn't match what was on checkpoint
    authorize @topic
    @posts = @topic.posts.includes(:user).paginate(page: params[:page], per_page: 10)
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def create
    @topic = Topic.new(params.require(:topic).permit(:name, :description, :public))
    authorize @topic
    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash[:error] = "Error creating topic. Please try again."
      render :new
    end
  end

    def update
      @topic = Topic.find(params[:id])
      authorize @topic
      if @topic.update_attributes(params.require(:topic).permit(:name, :description, :public))
        redirect_to @topic
      else
        flash[:error] = "Error saving topic. Please try again."
        render :edit
      end
    end

    def destroy
      @topic = Topic.find(params[:id])
      name = @topic.name

      authorize @topic
      if @topic.destroy
        flash[:notice] = "\"#{name}\" was deleted successfully."
        redirect_to topics_path
        #redirect_to @topic, notice: "Topic was destroyed." -- What I originally wrote
      else
        flash[:error] = "Error destroying topic. Please try again"
        render :show  # Originally wrote new, but realized that I'm not creating
      end
    end
  end


