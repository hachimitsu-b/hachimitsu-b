require 'test_helper'

class User::CdsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_cds_show_url
    assert_response :success
  end

  test "should get index" do
    get user_cds_index_url
    assert_response :success
  end

end
