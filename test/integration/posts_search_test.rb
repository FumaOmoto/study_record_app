require "test_helper"

class PostsSearchTest < ActionDispatch::IntegrationTest
  test "should show index correctly when blank" do
    get search_path
    assert_template "posts/index"
  end

  test "should show index correctly" do
    get search_path, params: {keyword: "doggo doggo doggo"}
    assert_template "posts/index"
    assert_select "h3", "投稿 (1)"
    assert_select "div.post-list li", count: 1
    assert_select "span.post-body", "doggo doggo doggo" 
  end
end
