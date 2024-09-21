require "test_helper"

class MeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should be redirected to sign in page if unauthenticated" do
    get me_index_url
    assert_redirected_to "/users/sign_in"
  end

  test "should be able to access profile page if authen" do
    require "JSON"
    provider_data = {
      provider: "odt",
      uid: 123,
      info: {
        email: "test@mailinator.com",
        image: "",
        first_name: "m",
        last_name: "x"
      }
    }.to_json
    sign_in User.create_from_provider_data(JSON.parse(provider_data, object_class: OpenStruct))
    get me_index_url
    assert_response :success
  end
end
