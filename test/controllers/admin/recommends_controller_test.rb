require 'test_helper'

class Admin::RecommendsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_recommends_index_url
    assert_response :success
  end

end
