class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 30}
  validates :body, presence: true, length: {maximum: 3000}
  
end
