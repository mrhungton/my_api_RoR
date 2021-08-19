require "test_helper"

class BlogTest < ActiveSupport::TestCase
  test "should have a positive title" do
    blog = blogs(:one)
    blog.title = 'There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain'
    assert_not blog.valid?
  end    
end
