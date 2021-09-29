require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  let!(:post_one) { FactoryBot.create(:post) }
  let!(:post_two) { FactoryBot.create(:post) }

  scenario "user creates a new post" do
    visit "/posts/new"
    fill_in "Title", with: "Hello"
    fill_in "Body", with: "World"
    click_button "Create Post"
    expect(page).to have_content "Hello"
    expect(page).to have_content "World"
  end

  scenario "user inputs invalid attributes" do
    visit "/posts/new"
    fill_in "Body", with: "World"
    click_button "Create Post"
    expect(page).to have_content "can't be blank"
  end

  scenario "user can view all posts" do
    visit "/posts"
    expect_post_onpage post_one
    expect_post_onpage post_two
  end

  scenario "user can view a single post with id" do
    visit post_path post_one.id
    expect_post_onpage post_one
    expect_post_not_onpage post_two
  end

  scenario "user can view a single post with slug" do
    visit post_path post_one.slug
    expect_post_onpage post_one
    expect_post_not_onpage post_two
  end
end

def expect_post_onpage(post)
  aggregate_failures do
    expect(page).to have_content post.title
    expect(page).to have_content post.body
  end
end

def expect_post_not_onpage(post)
  aggregate_failures do
    expect(page).to_not have_content post.title
    expect(page).to_not have_content post.body
  end
end