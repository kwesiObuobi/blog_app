class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, foreign_key: :post_id
  has_many :likes, foreign_key: :post_id

  validates :title, presence: true, length: { in: 1..250 }
  validates :text, presence: true, length: { in: 1..500 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_save :update_posts_counter
  after_initialize :initialize_counters

  def update_posts_counter
    author.increment!(:posts_counter)
  end

  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def initialize_counters
    self.likes_counter = likes_counter.to_i
    self.comments_counter = comments_counter.to_i
  end
end
