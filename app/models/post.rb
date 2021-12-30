class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 30}
  validates :body, presence: true, length: {maximum: 6000}
  validates :category, presence: true
  
  #keyword,categoryに一致する記事を返す
  def Post.search(keyword, category)
    if !(category == "全て選択")
      where("(title like? OR body like?) AND category like?",
                "%#{keyword}%", "%#{keyword}%", "%#{category}%")
    else
      where("title like? OR body like?",
                "%#{keyword}%", "%#{keyword}%")
    end
  end
end
