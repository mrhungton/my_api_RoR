require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user with a valid email should be valid" do
    user = User.new(email: "test@example.com", password_digest: "test", role: "user")
    assert user.valid?
  end

  test "user with invalid email should be invalid" do
    user = User.new(email: "test", password_digest: "test", role: "user")
    assert_not user.valid?
  end

  test "user with taken email should be invalid" do
    other_user = users(:user1)
    user = User.new(email: other_user.email, password_digest: "test", role: "user")
    assert_not user.valid?
  end
end
