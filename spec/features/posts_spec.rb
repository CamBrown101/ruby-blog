require 'rails_helper'

RSpec.feature "Posts", type: :feature do
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
end
