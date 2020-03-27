require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Aga")
  end

  test "should be valid" do
    @user.valid?
  end

  test "name should be present and not too long" do
    @user.name = "          "
    assert_not @user.valid?
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "name should be unique" do
    duplicate = @user.dup
    duplicate.name.upcase!
    @user.save
    assert_not duplicate.valid?
  end
end
