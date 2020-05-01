require 'test_helper'

class UserActivationTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @admin = users(:admin)
    @user = users(:fresh)
  end

  test "should let admin send activation linkt when user not activated" do
    log_in_as @admin
    get user_path(@user)
    assert_match "Wysłać", response.body
    assert_match "MUSISZ NAJPIERW DODAĆ ADRES EMAIL DO KONTA", response.body
    @user.update_attribute(:email, "foobar@foobar.com")
    assert_match "foobar@foobar.com", @user.email
    get user_path(@user)
    assert_match "Email aktywacyjny będzie wysłany na adres:", response.body
    assert_select 'a[href=?]', toggle_activating_user_path(@user)
    assert_not @user.activating
    # start user activation
    get toggle_activating_user_path(@user)
    assert @user.reload.activating
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not @user.activation_digest.nil?
    assert_not @user.activated
    # send another activation email
    get user_path(@user)
    assert_match "Wysłać jeszcze raz?", response.body
    first_activation_digest = @user.activation_digest
    get toggle_activating_user_path(@user)
    assert @user.reload.activating
    assert_equal 2, ActionMailer::Base.deliveries.size
    assert_not first_activation_digest == @user.activation_digest
  end
end
