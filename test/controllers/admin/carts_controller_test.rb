require 'test_helper'

class Admin::CartsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_carts_index_url
    assert_response :success
  end

end
