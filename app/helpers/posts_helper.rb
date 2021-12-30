module PostsHelper
  def has_this_post(post)
    user = User.find_by(id: post.user_id)
  end

  def has_this_post?(post)
    user = User.find_by(id: post.user_id)
    current_user == user ? true : false
  end

  def category_to_name(category)
    case category
      when "japanese"
        "国語"
      when "math"
        "数学"
      when "science"
        "理科"
      when "social"
        "社会"
      when "foreign lang"
        "外国語"
      when "others"
        "その他"
    end
  end
end
