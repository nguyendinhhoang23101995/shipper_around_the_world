require 'test_helper'

class ProductTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get product_types_new_url
    assert_response :success
  end

  test "should get create" do
    get product_types_create_url
    assert_response :success
  end

end
