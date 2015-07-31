class Api::V1::AuthenticatedCustomerController < Api::V1::ApiController
  before_action :authenticate_customer

  protected
    def customer_unauthenticated
      api_error(status: 401, error: 'User unauthenticated')
    end

  private
    def authenticate_customer
      if @auth_header.length != 3
        customer_unauthenticated
      else
        @user = User.find_by username: @auth_header[1]
        if !(user && Devise.secure_compare(user.api_token, @auth_header[2]))
          customer_unauthenticated
        end
      end
    end
end
