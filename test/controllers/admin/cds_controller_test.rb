require 'test_helper'

class Admin::CdsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_cds_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_cds_show_url
    assert_response :success
  end

  test "should get new" do
    get admin_cds_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_cds_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_cds_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_cds_update_url
    assert_response :success
  end

end
