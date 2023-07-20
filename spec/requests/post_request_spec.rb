require 'rails_helper'

describe Post, type: :request do
  before do
    @user = User.create(name: 'Sam', photo: 'photo.url', bio: 'Excellent', posts_counter: 0)
    @post = Post.create(author: @user, title: 'Let us go', text: 'This is the text for the post', likes_counter: 0,
                        comments_counter: 0)
  end

  describe 'routes with post_controller' do
    it 'should render the index action correctly' do
      get "/users/#{@user.id}/posts"
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response).to render_template('posts/index')
      expect(response.body).to include('Comments')
    end

    it 'should render the show action correctly' do
      get "/users/#{@user.id}/posts/#{@post.id}"
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response).to render_template('posts/show')
      expect(response.body).to include('Post #')
    end
  end
end
