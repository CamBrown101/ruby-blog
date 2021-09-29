class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :sequentially_slugged
  validates :title, presence: true
  validates :body, presence: true
end
