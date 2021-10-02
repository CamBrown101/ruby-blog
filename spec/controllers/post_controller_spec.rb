require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "#index" do
    it "responds successfully" do
      get :index
      aggregate_failures do
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end

    it "renders post index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do
    context "with valid attributes" do
      let(:post_params) { FactoryBot.attributes_for(:post) }

      it "responds successfully" do
        post :new, params: { post: post_params }
        aggregate_failures do
          expect(response).to be_successful
          expect(response).to have_http_status "200"
        end
      end
    end
  end

  describe "#create" do
    context "with valid attributes" do
      let(:post_params) { FactoryBot.attributes_for(:post) }

      it "redirects correctly" do
        post :create, params: {post: post_params}
        @post = Post.last
        aggregate_failures do
          expect(response).to have_http_status "302"
          expect(response).to redirect_to(post_path @post.id)
        end
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

          it "add a new post" do
            post_params = FactoryBot.attributes_for(:post, title: nil)
            expect{
              post :create, params: {post: post_params}
            }.to_not change(Post, :count)
          end
        end

      context "without body" do
        let(:post_params) { FactoryBot.attributes_for(:post, body: nil) }
        it "does not redirect" do
          post :create, params: {post: post_params}
          aggregate_failures do
            expect(response).to be_successful
            expect(response).to have_http_status "200"
          end
        end

        it "renders new template" do
          post :create, params: {post: post_params}
          expect(response).to render_template(:new)
        end

        it "add a new post" do
          post_params = FactoryBot.attributes_for(:post, body: nil)
          expect{
            post :create, params: {post: post_params}
          }.to_not change(Post, :count)
        end
      end
    end
  end

  describe "#show" do
    context "with valid attributes" do
        it "returns successfully" do
          @post = FactoryBot.create(:post)
          get :show, params: { id: @post.id }
          aggregate_failures do
            expect(response).to be_successful
            expect(response).to have_http_status "200"
          end
        end
      end

    context "with invalid attributes" do
      it "throws an error" do
        @post = FactoryBot.create(:post)
        expect {
          get :show, params: { id: nil }
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end

  describe "#destroy" do
    context "with valid attributes" do
      it "redirects correctly" do
        @post = FactoryBot.create(:post)
        delete :destroy, params: {id: @post.id}
        aggregate_failures do
          expect(response).to have_http_status "302"
        end
      end

      it "changes count by -1" do
        @post = FactoryBot.create(:post)
        expect {
          delete :destroy, params: {id: @post.id}
        }.to change(Post, :count).by(-1)
      end
    end

    context "with invalid attributes" do
      it "does not change count" do
        @post = FactoryBot.create(:post)
        expect {
          delete :destroy, params: {id: nil}
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end
end