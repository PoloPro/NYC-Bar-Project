require 'rails_helper'

RSpec.describe Achievement, type: :model do

  describe 'Facebook achievement' do
    before(:each) {@facebook_ach = Achievement.create!(name: "The Social Network")}
    it 'gives achievements to new users who signed in with Facebook' do
      user = User.create!(name: "R. Speck", provider: "facebook", email: "hahaha@hahaha.com", password: "password", password_confirmation: "password")
      Achievement.facebook_auth(user)
      expect(user.achievements).to include(@facebook_ach)
    end

    it "doesn't give achievements to new non-Facebook users" do
       user = User.create!(name: "R. Speck", email: "hahaha@hahaha.com", password: "password", password_confirmation: "password")
       Achievement.facebook_auth(user)
       expect(user.achievements).to_not include(@facebook_ach)
    end
  end

end
