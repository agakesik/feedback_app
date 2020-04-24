require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @skater_status = SkaterStatus.first
    @user = User.new(name: "Very new user", skater_status_id: @skater_status.id)
  end

  test "should be valid" do
    assert @user.valid?
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

  test "activated user should need valid password" do
    @user.activated = true
    assert_not @user.valid?
    @user.email = "aga@gmail.com"
    @user.password = @user.password_confirmation = "aa"
    assert_not @user.valid?
    @user.password = @user.password_confirmation = "foobar"
    assert @user.valid?
  end

  test "activated user should need valid email" do
    @user.activated = true
    @user.password = @user.password_confirmation = "foobar"
    assert_not @user.valid?
    @user.email = "aga@"
    assert_not @user.valid?
    @user.email = "aga@gmail.pl"
    assert @user.valid?
  end

  test "create_activation_digest should change activation_token" do
    assert_nil @user.activation_token
    assert_nil @user.activation_digest
    @user.activated = true
    @user.create_activation_digest
    assert_not @user.activation_token.nil?
  end
end
