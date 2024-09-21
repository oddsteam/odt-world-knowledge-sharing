require "test_helper"

class MeControllerTest < ActionDispatch::IntegrationTest
  test "should be redirected to sign in page if unauthenticated" do
    get me_index_url
    assert_redirected_to "/users/sign_in"
  end
end
