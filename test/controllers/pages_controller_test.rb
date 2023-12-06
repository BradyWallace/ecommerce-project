require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get permalink" do
    get pages_permalink_url
    assert_response :success
  end
end
