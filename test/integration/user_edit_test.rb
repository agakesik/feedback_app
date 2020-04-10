require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:aga)
    @skater_status = skater_statuses(:SS2)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "", skater_status_id: 0 } }
    assert_template 'users/edit'
    assert_select "div.error-explanation"
    assert_select "div.alert-danger", "Błędy w liczbie: 2"
  end

  test "successful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "lucyna"
    patch user_path(@user), params: { user: { name: name,
                                      skater_status_id: @skater_status.id } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal @skater_status.id, @user.skater_status.id
  end
end
