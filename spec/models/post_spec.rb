require 'rails_helper'

RSpec.describe Post, type: :model do
  it "is valid with a title and body"
  is "is invalid without a title"
  is "is invalid without a description"
end
