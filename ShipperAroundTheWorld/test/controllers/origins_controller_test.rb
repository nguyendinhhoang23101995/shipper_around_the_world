require 'test_helper'

class OriginsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get origins_new_url
    assert_response :success
  end

  test "should get create" do
    get origins_create_url
    assert_response :success
  end

end
