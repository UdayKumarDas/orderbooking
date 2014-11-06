require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get AddLocation" do
    get :AddLocation
    assert_response :success
  end

  test "should get EditLocation" do
    get :EditLocation
    assert_response :success
  end

end
