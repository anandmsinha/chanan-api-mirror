class Api::V1::WelcomeController < Api::V1::AuthenticatedCustomerController

  def index
    res = {success: true}
    render json: res.to_json, status: 200
  end
end
