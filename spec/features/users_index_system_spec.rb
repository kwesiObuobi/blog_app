require 'rails_helper'

RSpec.describe 'User', type: :feature do
  before(:each) do
    @abel = User.create(name: 'Abel Tsegaye', photo: 'https://abellinktophoto.jpg', bio: 'Make a diffrence',
                        posts_counter: 0)
    @sam = User.create(name: 'Samuel', photo: 'https://samlinktophoto.jpg', bio: 'be the diffrence', posts_counter: 0)
  end

  describe 'user#index' do
    before(:each) do
      visit '/'
    end
    it 'should show the username of all other users.' do
      expect(page).to have_content(@abel.name)
      expect(page).to have_content(@sam.name)
    end
    it 'should show the profile picture for each user.' do
      expect(page).to have_xpath("//img[contains(@src,'https://abellinktophoto.jpg')]")
    end
    it 'should show number of posts each user has written.' do
      expect(page).to have_content 'Number of posts: 0'
    end

    it 'should redirected to that user show page, When I click on a user' do
      click_link 'Abel Tsegaye'
      expect(page).to have_current_path("/users/#{@abel.id}")
    end
  end
end
