require 'test_helper'

class User::CartsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_carts_index_url
    assert_response :success
  end

  test "should get new" do
    get user_carts_new_url
    assert_response :success
  end

  test "should get create" do
    get user_carts_create_url
    assert_response :success
  end

  test "should get edit" do
    get user_carts_edit_url
    assert_response :success
  end

  test "should get update" do
    get user_carts_update_url
    assert_response :success
  end

end
