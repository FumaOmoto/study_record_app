module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end
   
  def current_user
      @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user?(user)
    if user == current_user
      true
    elsif user != current_user
      false
    end
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil 
  end
end
