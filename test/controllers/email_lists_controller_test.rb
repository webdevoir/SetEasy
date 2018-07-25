require 'test_helper'

class EmailListsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get email_lists_new_url
    assert_response :success
  end

  test "should get show" do
    get email_lists_show_url
    assert_response :success
  end

  test "should get index" do
    get email_lists_index_url
    assert_response :success
  end

end
