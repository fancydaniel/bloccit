require 'rails_helper'

describe 'Visiting profiles' do 

  include TestFactories

  before do
    # @comment = Comment.new(user: @user, body: "A Comment", post: @post)
    # @user = authenticated_user
    # @post = associated_post(user: @user)
    @user = create(:user)
    @post = create(:post, user: @user)
    @comment = build(:comment, user @user, body: "A Comment")
    @comment.save
    
  end

  describe "not signed in" do
    
    it "shows profile" do
      visit user_path(@user)

      
    allow(@comment).to receive(:send_favorite_emails)
    @comment.save  

      save_and_open_page
      expect(current_path).to eq(user_path(@user))

      expect( page ).to have_content(@user.name)
      expect( page ).to have_content(@post.title)
      expect( page ).to have_content(@comment.body)
    end
  end
  
end