require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without password" do
    user = User.new(email_address: "user@example.com")
    assert_not user.save, "Saved the user without a password"
  end

  test "should save user with a password" do
    user = User.new(email_address: "user@example.com", password: "password123", password_confirmation: "password123")
    assert user.save, "Couldn't save the user with a password"
  end

  test "should authenticate user with correct password" do
    user = User.create(email_address: "user@example.com", password: "password123", password_confirmation: "password123")
    assert user.authenticate("password123"), "Authentication failed with correct password"
  end

  test "should not authenticate user with incorrect password" do
    user = User.create(email_address: "user@example.com", password: "password123", password_confirmation: "password123")
    assert_not user.authenticate("wrongpassword"), "Authenticated with incorrect password"
  end

  test "should normalize email address before saving" do
    user = User.new(email_address: "  UsEr@ExAmPlE.CoM   ", password: "password123", password_confirmation: "password123")
    user.save
    assert_equal "user@example.com", user.email_address, "Email address was not normalized"
  end
end
