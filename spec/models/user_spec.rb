require 'rails_helper'

describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is valid with a username, password and email" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "is invalid without a username" do
    user = FactoryBot.build(:user,username: nil)
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "is invalid without a unique username" do
    user_one = FactoryBot.create(:user, username: "hello")
    user_two = FactoryBot.build(:user, username: "hello")
    user_two.valid?
    expect(user_two.errors[:username]).to include("has already been taken")
  end

  it "is invalid without a email" do
    user = FactoryBot.build(:user,email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a unique email" do
    user_one = FactoryBot.create(:user, email: "hello@email.com")
    user_two = FactoryBot.build(:user, email: "hello@email.com")
    user_two.valid?
    expect(user_two.errors[:email]).to include("has already been taken")
  end

  it "is invalid without a real email" do
    user = FactoryBot.build(:user, email: "test")
    user.valid?
    expect(user.errors[:email]).to include("Invalid email")
  end
end
