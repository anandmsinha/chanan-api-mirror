require 'test_helper'

class Api::V1::WelcomeControllerTest < ActionController::TestCase
  fixtures :all

  test "without authorization header api return 401" do
    get :index
    assert_same 401, response.status
  end

  test "correct authorization header" do
    request.headers['HTTP_AUTHORIZATION'] = 'Maharaj:tripanki:oho'
    get :index
    assert_same 200, response.status
  end
end
