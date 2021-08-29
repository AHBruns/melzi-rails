require "test_helper"

class PasswordRecoveryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get password_recovery_url
    assert_response :success
  end

  test "should get send_email" do
    get send_password_recovery_email_url
    assert_response :success
  end

  test "should get reset_password" do
    get reset_password_url
    assert_response :success
  end

  test "should get complete" do
    get password_recovery_complete_url
    assert_response :success
  end
end
