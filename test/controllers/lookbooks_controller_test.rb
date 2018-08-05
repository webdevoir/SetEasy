require 'test_helper'

class LookbooksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get lookbooks_new_url
    assert_response :success
  end

  test "should get index" do
    get lookbooks_index_url
    assert_response :success
  end

  test "should get edit" do
    get lookbooks_edit_url
    assert_response :success
  end

  test "should get show" do
    get lookbooks_show_url
    assert_response :success
  end

end
