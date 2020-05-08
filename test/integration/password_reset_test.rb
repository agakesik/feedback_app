require 'test_helper'

class PasswordResetTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:aga)
  end

  test "successful password reset" do
    get new_password_reset_path
    post password_resets_path, params: { password_reset: { email: @user.email } }
    @user = assigns(:user)
    patch password_reset_path(@user.reset_token),
        params: { email: @user.email, user: { password: "foobar1",
                                              password_confirmation: "foobar1" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_nil @user.reset_sent_at
    assert_nil @user.reset_sent_at
  end

  test "expired token" do
    get new_password_reset_path
    post password_resets_path, params: { password_reset: { email: @user.email } }
    @user = assigns(:user)
    @user.update_attribute(:reset_sent_at, 4.hours.ago)
    patch password_reset_path(@user.reset_token),
        params: { email: @user.email, user: { password: "foobar1",
                                              password_confirmation: "foobar1" } }
    assert_redirected_to new_password_reset_url
    follow_redirect!
    assert_match "stracił ważność", response.body
  end

  test "submiting blank new password" do
    get new_password_reset_path
    post password_resets_path, params: { password_reset: { email: @user.email } }
    @user = assigns(:user)
    patch password_reset_path(@user.reset_token),
        params: { email: @user.email, user: { password: "",
                                              password_confirmation: "" } }
    assert_template 'password_resets/edit'
    assert_select 'div.error-explanation'
  end
end
