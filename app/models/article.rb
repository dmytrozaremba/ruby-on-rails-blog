class Article < ApplicationRecord
  include Visible
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      Article.all
    end
  end
end
