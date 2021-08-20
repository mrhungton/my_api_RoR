require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user with a valid email should be valid" do
    user = User.new(email: "test@example.com", password_digest: "123456", role: "user", name: "test")
    assert user.valid?
  end

  test "user with invalid email should be invalid" do
    user = User.new(email: "test", password_digest: "123456", role: "user", name: "test")
    assert_not user.valid?
  end

  test "user with taken email should be invalid" do
    other_user = users(:user1)
    user = User.new(email: other_user.email, password_digest: "654321", role: "user", name: "test")
    assert_not user.valid?
  end

  test "should filter users by name" do
    assert_equal 2, User.filter_by_name('freec').count
  end

  test "should filter users by name and sort them" do
    assert_equal [users(:admin), users(:another_freec)], User.filter_by_name('freec').sort
  end

  test "should filter users by email and sort them" do
    assert_equal [users(:user1), users(:user2)], User.filter_by_email('user').sort
  end

  test 'should sort user by most recent' do
    # we will touch some users to update them
    # users(:user1).touch
    assert_equal [users(:another_freec), users(:user1), users(:user2), users(:admin)], User.recent.to_a
  end
end
