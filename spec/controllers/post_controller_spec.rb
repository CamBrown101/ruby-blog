require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    describe "#new" do
        let(:post_params) { FactoryBot.attributes_for(:post) }
        it "responds successfully" do
            post :new, params: { post: post_params }
            expect(response).to be_successful
        end

        it "returns a 200" do
            post :new, params: { post: post_params }
            expect(response).to have_http_status "200"
        end
    end

    describe "#create" do
        context "with valid attributes" do
            let(:post_params) { FactoryBot.attributes_for(:post) }
            it "returns a 302" do
                post :create, params: { post: post_params }
                expect(response).to have_http_status "302"
            end

            it "redirects correctly" do
                post :create, params: {post: post_params}
                @post = Post.last
                expect(response).to redirect_to(post_path @post.id)
            end

            it "add a new post" do
                post_params = FactoryBot.attributes_for(:post)
                expect{
                    post :create, params: {post: post_params}
                }.to change(Post, :count).by(1)
            end
        end

        context "with invalid attributes" do
            context "without title" do
                let(:post_params) { FactoryBot.attributes_for(:post, title: nil) }
                it "does not redirect" do
                    post :create, params: {post: post_params}
                    expect(response).to have_http_status "200"
                end

                it "renders new template" do
                    post :create, params: {post: post_params}
                    expect(response).to render_template(:new)
                end
            end

            context "without body" do
                let(:post_params) { FactoryBot.attributes_for(:post, body: nil) }
                it "does not redirect" do
                    post :create, params: {post: post_params}
                    expect(response).to have_http_status "200"
                end

                it "renders new template" do
                    post :create, params: {post: post_params}
                    expect(response).to render_template(:new)
                end
            end

        end
    end

    describe "#show" do
        context "with valid attributes" do
            it "returns a 200" do
                @post = FactoryBot.create(:post)
                get :show, params: { id: @post.id }
                expect(response).to have_http_status "200"
            end
        end

        context "with invalid attributes" do
            it "returns a 404" do
                @post = FactoryBot.create(:post)
                expect{
                    get :show, params: { id: nil }
                }.to raise_error(ActionController::UrlGenerationError)
            end
        end
    end
end