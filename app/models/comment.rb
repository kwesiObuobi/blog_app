class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :text, presence: true, length: { minimum: 1, maximum: 500 }

  after_save :update_comments_counter

  before_destroy -> { Post.find_by(id: post_id).decrement!(:comments_counter) }

  def update_comments_counter
    post.comments_counter = post.comments_counter.to_i + 1
    post.save
  end
end
