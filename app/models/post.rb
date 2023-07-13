class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, foreign_key: :post_id
  has_many :likes, foreign_key: :post_id

  before_save :update_posts_counter

  def update_posts_counter
    count = if author.posts_counter.nil?
              0
            else
              author.posts_counter
            end
    author.posts_counter = count + 1
    author.save
  end

  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
