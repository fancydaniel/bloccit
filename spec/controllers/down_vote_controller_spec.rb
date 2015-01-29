require 'rails_helper'

  describe Down_Vote do

    include TestFactories
    include Devise::TestHelpers

    before do
      @post = Post.new(title: 'Post title', body: 'Post bodies must be pretty long.')
      allow(@post).to receive(:create_vote)
      @post.save
      2.times { @post.votes.create(value: -1) }
    end



  describe '#up_vote' do
    it "adds an up-vote to the post" do
      request.env["HTTP_REFERER"] = '/'
      @user = authenticated_user
      @post = associated_post
      sign_in @user

      expect {
        post( :up_vote, post_id: @post.id)
      }.to change { @post.up_votes}.by 1
    end



  end
