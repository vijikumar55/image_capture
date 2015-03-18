require 'test_helper'

class FinalControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
