require 'rails_helper'

describe Post, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:post)).to be_valid
  end

  it "is valid with a title and body" do
    post = FactoryBot.build(:post)
    expect(post).to be_valid
  end

  it "is invalid without a title" do
    post = FactoryBot.build(:post,title: nil)
    post.valid?
    expect(post.errors[:title]).to include("can't be blank")
  end

  it "is invalid without a unique title" do
    post_one = FactoryBot.create(:post, title: "hello")
    post_two = FactoryBot.build(:post, title: "hello")
    post_two.valid?
    expect(post_two.errors[:title]).to include("has already been taken")
  end
  
  it "is invalid without a body" do
    post = FactoryBot.build(:post, body: nil)
    post.valid?
    expect(post.errors[:body]).to include("can't be blank")
  end

  it "is invalid without a body and title" do
    post = FactoryBot.build(:post, body: nil, title: nil)
    post.valid?
    expect(post.errors[:body]).to include("can't be blank")
  end
end
