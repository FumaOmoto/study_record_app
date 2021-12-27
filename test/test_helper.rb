ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def is_logged_in?
    !session[:user_id].nil?
  end
  
  def log_in_as(user)
    session[:user_id] = user.id
  end

  def has_this_post(post)
    user = User.find_by(id: post.user_id)
  end

  def has_this_post?(post)
    user = User.find_by(id: post.user_id)
    current_user == user ? true : false
  end

  def has_this_comment(comment)
    user = User.find_by(id: comment.user_id)
  end

  def has_this_comment?(comment)
    user = User.find_by(id: comment.user_id)
    current_user == user ? true : false
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
end

class ActionDispatch::IntegrationTest
  def log_in_as(user, password: "password", remember_me: "1")
    post login_path, params: {session: {email: user.email,
                                        password: password,
                                        remember_me: remember_me}}
  end
end