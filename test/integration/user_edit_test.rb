require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:aga)
    @user.activation_email_send = true
    @skater_status = skater_statuses(:SS2)
    @coach = users(:coach)
    # @inactive_user = users(:jago)
  end

  test "unsuccessful edit" do
    log_in_as(@coach)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "", skater_status_id: 0,
                                     email: "a.p"} }
    assert_template 'users/edit'
    assert_select "div.error-explanation"
    assert_select "div.alert-danger", "Błędy w liczbie: 3"
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "lucyna"
    patch user_path(@user), params: { user: { name: name,
                        skater_status_id: @skater_status.id,
                        email: @user.email,
                        password: 'foobar',
                        password_confirmation: 'foobar'    } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal @skater_status.id, @user.skater_status.id
  end

  test "successful edit without submiting password" do
    log_in_as(@coach)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "lucyna"
    patch user_path(@user), params: { user: { name: name,
                        skater_status_id: @skater_status.id,
                        email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal @skater_status.id, @user.skater_status.id
  end

  test "activating account" do

  end
end
