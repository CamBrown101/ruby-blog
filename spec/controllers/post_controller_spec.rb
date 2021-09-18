require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    describe "#new" do
        it "responds successfully" do
            post_params = FactoryBot.attributes_for(:post)
            post :new, params: { post: post_params }
            expect(response).to be_successful
        end

        it "returns a 200" do
            post_params = FactoryBot.attributes_for(:post)
            post :new, params: { post: post_params }
            expect(response).to have_http_status "200"
        end
    end

    describe "#create" do
        context "with valid attributes" do
            it "returns a 302" do
                post_params = FactoryBot.attributes_for(:post)
                post :create, params: { post: post_params }
                expect(response).to have_http_status "302"
            end

            it "redirects correctly" do
                @post = FactoryBot.create(:post)
                post_params = FactoryBot.attributes_for(:post)
                post :create, params: {post: post_params}
                expect(response).to redirect_to(post_path @post.id + 1)
            end
        end

        context "with invalid attributes" do
            it "does not redirect" do
                @post = FactoryBot.create(:post)
                post_params = FactoryBot.attributes_for(:post, :invalid_title)
                post :create, params: {post: post_params}
                expect(response).to_not redirect_to(post_path @post.id + 1)
            end
        end
    end

    describe "#show" do
        it "returns a 200" do
            @post = FactoryBot.create(:post)
            get :show, params: { id: @post.id }
            expect(response).to have_http_status "200"
        end
    end
end