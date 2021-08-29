require "test_helper"

class EmailVerificationControllerTest < ActionDispatch::IntegrationTest
  test "should get email_verification_required" do
    get email_verification_required_url
    assert_response :success
  end

  test "should get email_verification_complete" do
    get email_verification_complete_url
    assert_response :success
  end
end
