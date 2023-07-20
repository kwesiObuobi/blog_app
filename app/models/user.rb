class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :three_recent_posts, ->(user) { user.posts.order(created_at: :desc).limit(3) }

  after_initialize :initialize_posts_counter, :set_avatar

  private

  def set_avatar
    max_id = User.maximum('id')
    self.photo ||= "https://i.pravatar.cc/100?u=#{max_id + 1}"
  end

  def initialize_posts_counter
    self.posts_counter = posts_counter.to_i
  end
end
