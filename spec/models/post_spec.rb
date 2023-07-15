require 'rails_helper'

describe Post, type: :model do
  @user = User.new(name: 'Sam', photo: 'photo.url', bio: 'Excellent', posts_counter: 0)
  subject { Post.new(author: @user, title: 'Let us go', text: 'This is the text for the post') }

  before { subject.save }

  it 'should have an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should have a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'confirms likes_counter is greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'confirms comments_counter is greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should update the author\'s posts_counter' do
    new_user = User.create(name: 'Sam', photo: 'photo.url', bio: 'Excellent', posts_counter: 0)
    new_post = Post.create(author: new_user, title: 'Let us go', text: 'This is the text for the post', comments_counter: 0, likes_counter: 0)
    expect(new_user.posts_counter).to eq(1)
  end

  it 'confirms method does not return more than 5 recent comments' do
    new_user = User.create(name: 'Sam', photo: 'photo.url', bio: 'Excellent', posts_counter: 0)
    new_post = Post.create(author: new_user, title: 'Let us go', text: 'This is the text for the post', comments_counter: 0, likes_counter: 0)
    expect(new_post.five_recent_comments.length).to be <= 5
  end
end
