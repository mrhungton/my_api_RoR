require "test_helper"

class Api::V1::BlogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blog = blogs(:one)
  end

  test "should show blogs" do
    get api_v1_blogs_url(), as: :json
    assert_response :success
  end

  test "should show blog" do
    get api_v1_blog_url(@blog), as: :json
    assert_response :success

    json_response = JSON.parse(self.response.body)
    assert_equal @blog.title, json_response['title']
  end

  test "should create blog" do
    assert_difference('Blog.count') do
      post api_v1_blogs_url,
        params: {blog: {title: "#{@blog.title} (2)", content: @blog.content, published_date: @blog.published_date}},
        headers: {Authorization: JsonWebToken.encode(user_id: @blog.user_id)},
        as: :json
    end
    assert_response :created
  end

  test "should forbid create blog" do
    assert_no_difference('Blog.count') do
      post api_v1_blogs_url,
        params: {blog: {title: "#{@blog.title} (2)", content: @blog.content, published_date: @blog.published_date}}, 
        as: :json
    end
    assert_response :forbidden
  end

  test "should update blog" do
    patch api_v1_blog_url(@blog), 
      params: {blog: {title: @blog.title}},
      headers: {Authorization: JsonWebToken.encode(user_id: @blog.user_id)},
      as: :json
    assert_response :success
  end

  # test "should forbid update blog" do
  #   patch api_v1_blog_url(@blog),
  #     params: { blog: {title: @blog.title}},
  #     headers: {Authorization: JsonWebToken.encode(user_id: users(:user1).id)},
  #     as: :json
  #   assert_response :forbidden
  # end

  test "should destroy blog" do
    assert_difference('Blog.count', -1) do
      delete api_v1_blog_url(@blog),
        headers: {Authorization: JsonWebToken.encode(user_id: @blog.user_id)},
        as: :json
    end
    assert_response :no_content
  end

  # test "should forbid destroy blog" do
  #   assert_no_difference('Blog.count') do
  #     delete api_v1_blog_url(@blog),
  #       headers: {Authorization: JsonWebToken.encode(user_id: @blog.user_id)}, 
  #       as: :json
  #   end
  #   assert_response :forbidden
  # end
end
