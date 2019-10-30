require 'rails_helper'

RSpec.describe VideosController, type: :controller do
  let!(:user) {create(:user)}
  let!(:videos) {create_list(:video, 30, user: user)}

  describe "index" do
    context "request first page" do
      before do
        get :index
      end
      it("should return movies") do
        JSON.parse(response.body).tap do |json|
          expect(json['pagination']['total_count']).to eq(Video.count)
          expect(json['pagination']['page']).to eq(1)
          expect(json['pagination']['page_count']).to eq(2)
          expect(json['records'].length).to eq(20)
        end
      end
    end
  
    context "request second page" do
      before do
        get :index, params: { page: 2 }
      end
      it("should return movies") do
        JSON.parse(response.body).tap do |json|
          expect(json['pagination']['total_count']).to eq(Video.count)
          expect(json['pagination']['page']).to eq(2)
          expect(json['pagination']['page_count']).to eq(2)
          expect(json['records'].length).to eq(10)
        end
      end
    end

    context "request with params per page" do
      before do
        get :index, params: { page: 1, per_page: 15 }
      end
      it "should return movies" do
        JSON.parse(response.body).tap do |json|
          expect(json['pagination']['total_count']).to eq(Video.count)
          expect(json['pagination']['page']).to eq(1)
          expect(json['pagination']['page_count']).to eq(2)
          expect(json['records'].length).to eq(15)
        end
      end
    end
  end

  describe "create" do
    context "token is missing" do
      before do
        post :create
      end

      it "should return unauthorized" do
        expect(response.status).to eq(401)
      end
    end

    context "token is invalid" do
      before do
        @request.headers['Authorization'] = "Bearer invalidtoken"
        post :create
      end

      it "should return unauthorized" do
        expect(response.status).to eq(401)
      end
    end

    context "token is expired" do
      before do
        token = JsonWebToken.encode({id: user.id}, 3.minutes.ago)
        @request.headers['Authorization'] = "Bearer #{token}"
        post :create, params: {video: {user_id: user.id}}
      end

      it "should return unauthorized" do
        expect(response.status).to eq(401)
      end
    end

    context "link is missing in params" do
      let!(:user) { create(:user) }
      before do
        token = JsonWebToken.encode({id: user.id})
        @request.headers['Authorization'] = "Bearer #{token}"
        post :create, params: {video: {user_id: user.id}}
      end

      it "should return bad request" do
        expect(response.status).to eq(400)
      end
    end

    context "user_id is missing in params" do
      let!(:user) { create(:user) }
      before do
        token = JsonWebToken.encode({id: user.id})
        @request.headers['Authorization'] = "Bearer #{token}"
        post :create, params: {video: {link: "localhost"}}
      end

      it "should return bad request" do
        expect(response.status).to eq(400)
      end
    end

    context "create video succdess" do
      let!(:user) { create(:user) }
      before do
        token = JsonWebToken.encode({id: user.id})
        @request.headers['Authorization'] = "Bearer #{token}"
        post :create, params: {video: {link: "localhost", user_id: user.id}}
      end

      it "should return 201" do
        expect(response.status).to eq(201)
        JSON.parse(response.body).tap do |json|
          expect(json['record']['link']).to eq("localhost")
          expect(json['record']['id']).to_not be_nil
        end
      end
    end
  end
end
