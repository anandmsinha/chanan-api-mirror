require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "api_token is automatically generated on model save " do
    user = User.new(username: 'pal', password: 'bahubiokjsad')
    user.save!
    assert_not_nil user
    assert_not_nil user.api_token
  end
end
