require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @average_user = users(:aga)
    @other_user = users(:adam)
    @admin = users(:admin)
    @coach = users(:coach)
    @skill = skills(:plowstop)
    @skater_status = skater_statuses(:SS1)
  end

  test "should redirect user index page when not logged in as coach or admin" do
    get users_path
    assert_redirected_to login_url
    log_in_as(@average_user)
    get users_path
    assert_redirected_to root_url
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    log_in_as(@coach)
    get users_path
    assert_template 'users/index'
  end

  test "should not allow to destroy user when not logged in as admin" do
    assert_no_difference 'User.count' do
      delete user_path(@average_user)
    end
    log_in_as(@average_user)
    assert_no_difference 'User.count' do
      delete user_path(@average_user)
    end
    log_in_as(@admin)
    assert_difference 'User.count', -1 do
      delete user_path(@average_user)
    end
    log_in_as(@coach)
    assert_no_difference 'User.count' do
      delete user_path(@average_user)
    end
  end

  test "should redirect new user page when not logged in as coach" do
    get new_user_path
    assert_redirected_to login_url
    log_in_as(@average_user)
    get new_user_path
    assert_redirected_to root_url
    log_in_as(@admin)
    get new_user_path
    assert_redirected_to root_url
    log_in_as(@coach)
    get new_user_path
    assert_template 'users/new'
  end

  test "should not allow creating new skill via web" do
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "new user",
                                        skater_status_id: @skater_status.id } }
    end
    log_in_as(@average_user)
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "new user",
                                        skater_status_id: @skater_status.id } }
    end
    log_in_as(@admin)
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "new user",
                                        skater_status_id: @skater_status.id } }
    end
    log_in_as(@coach)
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "new user",
                                        skater_status_id: @skater_status.id } }
    end
  end

  test "should only allow user show page to coach, admin and said user" do
    # get user_path(@average_user)
    # assert_redirected_to root_url
    get user_path(@average_user)
    assert_redirected_to login_url
    log_in_as(@average_user)
    get user_path(@average_user)
    assert_template 'users/show'
    log_in_as(@other_user)
    get user_path(@average_user)
    assert_redirected_to root_url
    log_in_as(@admin)
    get user_path(@average_user)
    assert_template 'users/show'
    log_in_as(@coach)
    get user_path(@average_user)
    assert_template 'users/show'
  end

  test "should not allow editing user to anybody other and said user" do
    name = "new name"
    @params = { user: { name: name,
                        skater_status_id: @skater_status.id,
                        email: @average_user.email,
                        password: 'foobar',
                        password_confirmation: 'foobar'    } }
    # not logged in user
    patch user_path(@average_user), params: @params
    assert_match @average_user.reload.name, "Aga"
    assert_redirected_to login_path
    # other users
    log_in_as(@other_user)
    patch user_path(@average_user), params: @params
    assert_match @average_user.reload.name, "Aga"
    assert_redirected_to root_url
    # current user
    log_in_as(@average_user)
    patch user_path(@average_user), params: @params
    assert_match @average_user.reload.name, "new name"
  end

  test "coach can also edit users" do
    assert_match @average_user.name, "Aga"
    log_in_as(@coach)
    patch user_path(@average_user), params: { user: { name: "new name",
                        skater_status_id: @skater_status.id,
                        email: @average_user.email,
                        password: 'foobar',
                        password_confirmation: 'foobar'    } }
    assert_match @average_user.reload.name, "new name"

  end


end
