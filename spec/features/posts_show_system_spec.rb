require 'rails_helper'

RSpec.describe 'User', type: :feature do
  before(:each) do
    @abel = User.create(name: 'Abel Tsegaye', photo: 'https://abellinktophoto.jpg', bio: 'Make a diffrence',
                        posts_counter: 0)
    @sam = User.create(name: 'Samuel', photo: 'https://samlinktophoto.jpg', bio: 'be the diffrence', posts_counter: 0)
    @post1 = Post.create(title: 'post 1 title',
                         text: 'post content 1',
                         comments_counter: 0,
                         likes_counter: 0,
                         author: @abel)
    @comment1 = Comment.create(text: 'First comment from Abel', author_id: @abel.id, post_id: @post1.id)
  end

  describe 'post show' do
    before(:each) do
      visit "/users/#{@abel.id}/posts/#{@post1.id}"
    end
    it 'I can see the posts title.' do
      expect(page).to have_content 'post 1 title'
    end
    it 'I can see who wrote the post.' do
      expect(page).to have_content 'Abel Tsegaye'
      expect(page).to have_content 'post 1 title by Abel Tsegaye'
    end
    it 'I can see how many comments it has.' do
      expect(page).to have_content 'Comments: 1'
      expect(page).to_not have_content 'Comments: 0'
    end
    it 'I can see how many likes it has.' do
      expect(page).to have_content 'Likes: 0'
      expect(page).to_not have_content 'Likes: 1'
    end
    it 'I can see the post body.' do
      expect(page).to have_content 'post content 1'
    end
    it 'I can see the username of each commentor.' do
      expect(page).to have_content @abel.name.to_s
    end
    it 'I can see the comment each commentor left.' do
      expect(page).to have_content 'First comment from Abel'
    end
  end
end
