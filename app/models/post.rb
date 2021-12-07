class Post < ApplicationRecord
  validates :title, uniqueness: true, presence: true
  validates :body, presence: true
  after_validation :set_slug, only: [:create]

  def to_param
    "#{id}-#{slug}"
  end

  def buzz=(value)
    @buzz = value
  end
  def buzz
    @buzz
  end
  def +(value)
    @buzz + 1
  end
  private

  def set_slug
    self.slug = title.to_s.parameterize 
  end 
end