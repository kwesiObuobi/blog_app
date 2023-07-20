require 'rails_helper'

describe User, type: :request do
  before do
    @user = User.create(name: 'Sam', photo: 'photo.url', bio: 'Excellent', posts_counter: 0)
  end

  describe 'routes with user_controller' do
    it 'should render the index action correctly' do
      get '/'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
      expect(response).to render_template('users/index')
      expect(response.body).to include('Number of posts')
    end

    it 'should render the show action correctly' do
      get "/users/#{@user.id}"
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
      expect(response).to render_template('users/show')
      expect(response.body).to include('Number of posts')
    end
  end
end
