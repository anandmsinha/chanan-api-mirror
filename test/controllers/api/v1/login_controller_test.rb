require 'test_helper'

class Api::V1::LoginControllerTest < ActionController::TestCase
  setup do
    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s
    @request.headers['HTTP_AUTHORIZATION'] = 'Maharaj'
  end

  test 'login should work fine' do
    post :submit, {username: 'tripanki', password: 'user123'}.to_json, format: "json"
    assert_response :success
  end
end
