require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "create" do
    context "create new user failed" do
      context "password is missing" do
        before do
        post :create, params: {user: {username: "tuong"}}
        end
        it "should return unauthorized" do
          expect(response.status).to eq(401)
        end
      end

      context "username is missing" do
        before do
        post :create, params: {user: {password: "123456"}}
        end
        it "should return unauthorized" do
          expect(response.status).to eq(401)
        end
      end

      context "username already taken" do
        let!(:user) { create(:user)}
        before do
          post :create, params: {user: {username: user.username}}
        end
        it "should return unauthorized" do
          expect(response.status).to eq(401)
        end
      end
    end

    context "create new user success" do
      before do
        post :create, params: {user: {username: "tuong", password: "123456"}}
      end
      it "should return 201" do
        expect(response.status).to eq(201)
        expect(User.count).to eq(1)
        JSON.parse(response.body).tap do |json|
          expect(json['token']).not_to be_nil 
          expect(json['username']).not_to be_nil 
          expect(json['user_id']).not_to be_nil 
        end
      end
    end

    context "login" do
      let!(:user) { create(:user) }
      before do
        post :create, params: {user: {username: "tuong", password: "123456"}}
      end
      it "should return 201" do
        expect(response.status).to eq(201)
        expect(User.count).to eq(2)
        JSON.parse(response.body).tap do |json|
          expect(json['token']).not_to be_nil 
          expect(json['username']).not_to be_nil 
          expect(json['user_id']).not_to be_nil 
        end
      end
    end
  end
end
