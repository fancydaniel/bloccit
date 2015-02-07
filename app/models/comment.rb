class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user


  # Added code below because not sure if I need to validate title, body etc.
  validates :post, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true

  after_create :send_favorite_emails

  private

  def send_favorite_emails
    post.favorites.each do |favorite|   
      if should_receive_update_for?(favorite)
        FavoriteMailer.new_comment(favorite.user, post, self).deliver
    end
  end
end

  def should_receive_update_for?(favorite)
    user_id != favorite.user_id && favorite.user.email_favorites?
  end
end