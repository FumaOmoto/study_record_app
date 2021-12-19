module PostsHelper
  def has_this_post(post)
    user = User.find_by(id: post.user_id)
  end

  def has_this_post?(post)
    user = User.find_by(id: post.user_id)
    current_user == user ? true : false
  end
end
