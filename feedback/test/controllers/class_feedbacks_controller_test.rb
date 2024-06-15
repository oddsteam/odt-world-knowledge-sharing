require "test_helper"

class ClassFeedbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get class_feedbacks_new_url
    assert_response :success
  end

  test "should get create" do
    get class_feedbacks_create_url
    assert_response :success
  end
end
