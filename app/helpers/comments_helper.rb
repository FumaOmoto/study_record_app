module CommentsHelper
  def has_this_comment(comment)
    user = User.find_by(id: comment.user_id)
  end

  def has_this_comment?(comment)
    user = User.find_by(id: comment.user_id)
    current_user == user ? true : false
  end
end
