require 'test_helper'

class ProjectUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get project_users_new_url
    assert_response :success
  end

end
