class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def new
  @user = User.new
end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Invalid user information"
      redirect_to edit_user_registration_path
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.visible_to(current_user).where(user_id: @user.id)
    @comments = @user.comments
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar, :email_favorites)
  end

end