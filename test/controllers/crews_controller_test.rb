require 'test_helper'

class CrewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get crews_index_url
    assert_response :success
  end

  test "should get show" do
    get crews_show_url
    assert_response :success
  end

  test "should get edit" do
    get crews_edit_url
    assert_response :success
  end

  test "should get new" do
    get crews_new_url
    assert_response :success
  end

end
