require "test_helper"

class Api::ClassFeedbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_class_feedbacks_index_url
    assert_response :success
  end
end
