class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :three_recent_posts, ->(user) { user.posts.order(created_at: :desc).limit(3) }

  after_initialize :initialize_posts_counter, :set_avatar

  before_validation -> { self.name = email.split('@')[0] }

  private

  def set_avatar
    max_id = User.maximum('id')
    new_id = max_id ? max_id + 1 : 1
    self.photo ||= "https://i.pravatar.cc/100?u=#{new_id}"
  end

  def initialize_posts_counter
    self.posts_counter = posts_counter.to_i
  end
end
