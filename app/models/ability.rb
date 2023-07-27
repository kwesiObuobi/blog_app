class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post

    return unless user.present?

    can :destroy, Post, author: user
    # can :destroy, Post.where(author_id: user.id)

    # can :destroy, Comment, author: user
    can :destroy, Comment.where(author_id: user.id)

    return unless user.role == 'admin'

    can :destroy, Post
    can :destroy, Comment
  end
end
